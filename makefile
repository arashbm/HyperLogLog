# object files, auto generated from source files
OBJDIR := .o
$(shell mkdir -p $(OBJDIR) >/dev/null)

# dependency files, auto generated from source files
DEPDIR := .d
$(shell mkdir -p $(DEPDIR) >/dev/null)

SRCDIR := src

CXX = g++
CC = $(CXX)
CXXFLAGS = -Werror -Wall -Wextra -Wconversion \
					 -O3 \
					 -std=c++14 \
					 -g \
					 -funroll-loops -ffast-math -ftree-vectorize -mtune=native \
					 -Idep/catch2/include \
					 -Idep/MurmurHash3/include

LD = g++

DEPFLAGS = -MT $@ -MMD -MP -MF $(DEPDIR)/$*.Td

COMPILE.c = $(CC) $(DEPFLAGS) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
COMPILE.cc = $(CXX) $(DEPFLAGS) $(CXXFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c
POSTCOMPILE = @mv -f $(DEPDIR)/$*.Td $(DEPDIR)/$*.d && touch $@

LINK.o = $(LD) $(LDFLAGS) $^ $(LOADLIBES) $(LDLIBS) -o $@

all: MurmurHash3.o tests

MurmurHash3.o: CXXFLAGS+=-Wno-implicit-fallthrough -Wno-sign-conversion
MurmurHash3.o: dep/MurmurHash3/src/MurmurHash3.cpp
	$(COMPILE.cc) $<

record_biases: MurmurHash3.o $(OBJDIR)/record_biases.o
	$(LINK.o)

estimate_distribution: MurmurHash3.o $(OBJDIR)/estimate_distribution.o
	$(LINK.o)

tests: MurmurHash3.o $(OBJDIR)/tests.o $(OBJDIR)/hll_tests.o
	$(LINK.o)

$(OBJDIR)/%.o : $(SRCDIR)/%.c
$(OBJDIR)/%.o : $(SRCDIR)/%.c $(DEPDIR)/%.d
	$(COMPILE.c) $(OUTPUT_OPTION) $<
	$(POSTCOMPILE)

$(OBJDIR)/%.o : $(SRCDIR)/%.cc
$(OBJDIR)/%.o : $(SRCDIR)/%.cc $(DEPDIR)/%.d
	$(COMPILE.cc) $(OUTPUT_OPTION) $<
	$(POSTCOMPILE)

$(OBJDIR)/%.o : $(SRCDIR)/%.cpp
$(OBJDIR)/%.o : $(SRCDIR)/%.cpp $(DEPDIR)/%.d
	$(COMPILE.cc) $(OUTPUT_OPTION) $<
	$(POSTCOMPILE)

$(OBJDIR)/%.o : $(SRCDIR)/%.cxx
$(OBJDIR)/%.o : $(SRCDIR)/%.cxx $(DEPDIR)/%.d
	$(COMPILE.cc) $(OUTPUT_OPTION) $<
	$(POSTCOMPILE)

$(DEPDIR)/%.d: ;
.PRECIOUS: $(DEPDIR)/%.d

include $(wildcard $(DEPDIR)/*.d)
