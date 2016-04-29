## Process this file with automake to produce Makefile.in

# Copyright (c) 2011, Google Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
#     * Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
# copyright notice, this list of conditions and the following disclaimer
# in the documentation and/or other materials provided with the
# distribution.
#     * Neither the name of Google Inc. nor the names of its
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


# This allows #includes to be relative to src/
AM_CPPFLAGS = -I$(top_srcdir)/src
AM_CFLAGS =
AM_CXXFLAGS =

if ANDROID_HOST
# This allows using fixed NDK headers when building for Android.
AM_CXXFLAGS += -I$(top_srcdir)/src/google_breakpad/common/android/include
# This is only necessary for building the unit tests until GTest is upgraded
# to a future version.
AM_CXXFLAGS += -I$(top_srcdir)/src/google_breakpad/common/android/testing/include
endif

if GCC
# These are good warnings to be treated as errors
AM_CXXFLAGS += \
	-Werror=missing-braces \
	-Werror=non-virtual-dtor \
	-Werror=overloaded-virtual \
	-Werror=reorder \
	-Werror=sign-compare \
	-Werror=unused-variable \
	-Werror=vla
endif

if LINUX_HOST
# Build as PIC on Linux, for linux_client_unittest_shlib
AM_CFLAGS += -fPIC
AM_CXXFLAGS += -fPIC
endif

# Specify include paths for ac macros
ACLOCAL_AMFLAGS = -I m4

# License file is called LICENSE not COPYING
AUTOMAKE_OPTIONS = foreign

## Documentation
docdir = $(prefix)/share/doc/$(PACKAGE)-$(VERSION)

dist_doc_DATA = \
	AUTHORS \
	ChangeLog \
	INSTALL \
	LICENSE \
	NEWS \
	README.md

## Headers
if LINUX_HOST
includeclhdir = $(includedir)/google_breakpad/client/linux/handler
includeclh_HEADERS = $(top_srcdir)/src/google_breakpad/client/linux/handler/*.h

includecldwcdir = $(includedir)/google_breakpad/client/linux/dump_writer_common
includecldwc_HEADERS = $(top_srcdir)/src/google_breakpad/client/linux/dump_writer_common/*.h

includeclmdir = $(includedir)/google_breakpad/client/linux/minidump_writer
includeclm_HEADERS = $(top_srcdir)/src/google_breakpad/client/linux/minidump_writer/*.h

includeclcdir = $(includedir)/google_breakpad/client/linux/crash_generation
includeclc_HEADERS = $(top_srcdir)/src/google_breakpad/client/linux/crash_generation/*.h

includelssdir = $(includedir)/google_breakpad/third_party/lss
includelss_HEADERS = $(top_srcdir)/src/google_breakpad/third_party/lss/*.h

includecldir = $(includedir)/google_breakpad/common/linux
includecl_HEADERS = $(top_srcdir)/src/google_breakpad/common/linux/*.h
endif

includegbcdir = $(includedir)/google_breakpad/common
includegbc_HEADERS = $(top_srcdir)/src/google_breakpad/common/*.h

includecdir = $(includedir)/google_breakpad/common
includec_HEADERS = $(top_srcdir)/src/google_breakpad/common/*.h

includepdir = $(includedir)/google_breakpad/processor
includep_HEADERS = $(top_srcdir)/src/google_breakpad/processor/*.h

## pkgconfig files
pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA =

## Common test logic
if SYSTEM_TEST_LIBS
TEST_CFLAGS = $(GTEST_CFLAGS) $(GMOCK_CFLAGS)
TEST_LIBS = $(GTEST_LIBS) -lgtest_main $(GMOCK_LIBS)
TEST_DEPS =
else
TEST_CFLAGS = \
	-I$(top_srcdir)/src/testing/include \
	-I$(top_srcdir)/src/testing/gtest/include \
	-I$(top_srcdir)/src/testing/gtest \
	-I$(top_srcdir)/src/testing
TEST_LIBS = src/testing/libtesting.a
TEST_DEPS = $(TEST_LIBS)
endif

## Libraries
check_LIBRARIES =
noinst_LIBRARIES =
lib_LIBRARIES =
bin_PROGRAMS =
check_PROGRAMS =
EXTRA_PROGRAMS =
CLEANFILES =

check_LIBRARIES += src/testing/libtesting.a

if !SYSTEM_TEST_LIBS
src_testing_libtesting_a_SOURCES = \
	src/testing/gtest/src/gtest-all.cc \
	src/testing/gtest/src/gtest_main.cc \
	src/testing/src/gmock-all.cc
src_testing_libtesting_a_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)
endif

if !DISABLE_PROCESSOR
lib_LIBRARIES += src/libbreakpad.a
pkgconfig_DATA += breakpad.pc
noinst_LIBRARIES += src/third_party/libdisasm/libdisasm.a
endif

if LINUX_HOST
lib_LIBRARIES += src/google_breakpad/client/linux/libbreakpad_client.a
pkgconfig_DATA += breakpad-client.pc

src_google_breakpad_client_linux_libbreakpad_client_a_SOURCES = \
	src/google_breakpad/client/linux/crash_generation/crash_generation_client.cc \
	src/google_breakpad/client/linux/crash_generation/crash_generation_server.cc \
	src/google_breakpad/client/linux/dump_writer_common/thread_info.cc \
	src/google_breakpad/client/linux/dump_writer_common/ucontext_reader.cc \
	src/google_breakpad/client/linux/handler/exception_handler.cc \
	src/google_breakpad/client/linux/handler/minidump_descriptor.cc \
	src/google_breakpad/client/linux/log/log.cc \
	src/google_breakpad/client/linux/microdump_writer/microdump_writer.cc \
	src/google_breakpad/client/linux/minidump_writer/linux_core_dumper.cc \
	src/google_breakpad/client/linux/minidump_writer/linux_dumper.cc \
	src/google_breakpad/client/linux/minidump_writer/linux_ptrace_dumper.cc \
	src/google_breakpad/client/linux/minidump_writer/minidump_writer.cc \
	src/google_breakpad/client/minidump_file_writer.cc \
	src/google_breakpad/common/convert_UTF.cc \
	src/google_breakpad/common/md5.cc \
	src/google_breakpad/common/string_conversion.cc \
	src/google_breakpad/common/linux/elf_core_dump.cc \
	src/google_breakpad/common/linux/elfutils.cc \
	src/google_breakpad/common/linux/file_id.cc \
	src/google_breakpad/common/linux/guid_creator.cc \
	src/google_breakpad/common/linux/linux_libc_support.cc \
	src/google_breakpad/common/linux/memory_mapped_file.cc \
	src/google_breakpad/common/linux/safe_readlink.cc
if ANDROID_HOST
src_google_breakpad_client_linux_libbreakpad_client_a_SOURCES += \
	src/google_breakpad/common/android/breakpad_getcontext.S
endif
endif LINUX_HOST

if !DISABLE_PROCESSOR
src_libbreakpad_a_SOURCES = \
	src/google_breakpad/common/breakpad_types.h \
	src/google_breakpad/common/minidump_format.h \
	src/google_breakpad/common/minidump_size.h \
	src/google_breakpad/processor/basic_source_line_resolver.h \
	src/google_breakpad/processor/call_stack.h \
	src/google_breakpad/processor/code_module.h \
	src/google_breakpad/processor/code_modules.h \
	src/google_breakpad/processor/dump_context.h \
	src/google_breakpad/processor/dump_object.h \
	src/google_breakpad/processor/exploitability.h \
	src/google_breakpad/processor/fast_source_line_resolver.h \
	src/google_breakpad/processor/memory_region.h \
	src/google_breakpad/processor/microdump.h \
	src/google_breakpad/processor/microdump_processor.h \
	src/google_breakpad/processor/minidump.h \
	src/google_breakpad/processor/minidump_processor.h \
	src/google_breakpad/processor/process_result.h \
	src/google_breakpad/processor/process_state.h \
	src/google_breakpad/processor/proc_maps_linux.h \
	src/google_breakpad/processor/source_line_resolver_base.h \
	src/google_breakpad/processor/source_line_resolver_interface.h \
	src/google_breakpad/processor/stack_frame.h \
	src/google_breakpad/processor/stack_frame_cpu.h \
	src/google_breakpad/processor/stack_frame_symbolizer.h \
	src/google_breakpad/processor/stackwalker.h \
	src/google_breakpad/processor/symbol_supplier.h \
	src/google_breakpad/processor/system_info.h \
	src/google_breakpad/processor/address_map-inl.h \
	src/google_breakpad/processor/address_map.h \
	src/google_breakpad/processor/basic_code_module.h \
	src/google_breakpad/processor/basic_code_modules.cc \
	src/google_breakpad/processor/basic_code_modules.h \
	src/google_breakpad/processor/basic_source_line_resolver_types.h \
	src/google_breakpad/processor/basic_source_line_resolver.cc \
	src/google_breakpad/processor/call_stack.cc \
	src/google_breakpad/processor/cfi_frame_info.cc \
	src/google_breakpad/processor/cfi_frame_info.h \
	src/google_breakpad/processor/contained_range_map-inl.h \
	src/google_breakpad/processor/contained_range_map.h \
	src/google_breakpad/processor/disassembler_x86.h \
	src/google_breakpad/processor/disassembler_x86.cc \
	src/google_breakpad/processor/dump_context.cc \
	src/google_breakpad/processor/dump_object.cc \
	src/google_breakpad/processor/exploitability.cc \
	src/google_breakpad/processor/exploitability_linux.h \
	src/google_breakpad/processor/exploitability_linux.cc \
	src/google_breakpad/processor/exploitability_win.h \
	src/google_breakpad/processor/exploitability_win.cc \
	src/google_breakpad/processor/fast_source_line_resolver_types.h \
	src/google_breakpad/processor/fast_source_line_resolver.cc \
	src/google_breakpad/processor/linked_ptr.h \
	src/google_breakpad/processor/logging.h \
	src/google_breakpad/processor/logging.cc \
	src/google_breakpad/processor/map_serializers-inl.h \
	src/google_breakpad/processor/map_serializers.h \
	src/google_breakpad/processor/microdump.cc \
	src/google_breakpad/processor/microdump_processor.cc \
	src/google_breakpad/processor/minidump.cc \
	src/google_breakpad/processor/minidump_processor.cc \
	src/google_breakpad/processor/module_comparer.cc \
	src/google_breakpad/processor/module_comparer.h \
	src/google_breakpad/processor/module_factory.h \
	src/google_breakpad/processor/module_serializer.cc \
	src/google_breakpad/processor/module_serializer.h \
	src/google_breakpad/processor/pathname_stripper.cc \
	src/google_breakpad/processor/pathname_stripper.h \
	src/google_breakpad/processor/postfix_evaluator-inl.h \
	src/google_breakpad/processor/postfix_evaluator.h \
	src/google_breakpad/processor/process_state.cc \
	src/google_breakpad/processor/proc_maps_linux.cc \
	src/google_breakpad/processor/range_map-inl.h \
	src/google_breakpad/processor/range_map.h \
	src/google_breakpad/processor/simple_serializer-inl.h \
	src/google_breakpad/processor/simple_serializer.h \
	src/google_breakpad/processor/simple_symbol_supplier.cc \
	src/google_breakpad/processor/simple_symbol_supplier.h \
	src/google_breakpad/processor/windows_frame_info.h \
	src/google_breakpad/processor/source_line_resolver_base_types.h \
	src/google_breakpad/processor/source_line_resolver_base.cc \
	src/google_breakpad/processor/stack_frame_cpu.cc \
	src/google_breakpad/processor/stack_frame_symbolizer.cc \
	src/google_breakpad/processor/stackwalker.cc \
	src/google_breakpad/processor/stackwalker_amd64.cc \
	src/google_breakpad/processor/stackwalker_amd64.h \
	src/google_breakpad/processor/stackwalker_arm.cc \
	src/google_breakpad/processor/stackwalker_arm.h \
	src/google_breakpad/processor/stackwalker_arm64.cc \
	src/google_breakpad/processor/stackwalker_arm64.h \
	src/google_breakpad/processor/stackwalker_address_list.cc \
	src/google_breakpad/processor/stackwalker_address_list.h \
	src/google_breakpad/processor/stackwalker_mips.cc \
	src/google_breakpad/processor/stackwalker_mips.h \
	src/google_breakpad/processor/stackwalker_ppc.cc \
	src/google_breakpad/processor/stackwalker_ppc.h \
	src/google_breakpad/processor/stackwalker_ppc64.cc \
	src/google_breakpad/processor/stackwalker_ppc64.h \
	src/google_breakpad/processor/stackwalker_sparc.cc \
	src/google_breakpad/processor/stackwalker_sparc.h \
	src/google_breakpad/processor/stackwalker_x86.cc \
	src/google_breakpad/processor/stackwalker_x86.h \
	src/google_breakpad/processor/static_address_map-inl.h \
	src/google_breakpad/processor/static_address_map.h \
	src/google_breakpad/processor/static_contained_range_map-inl.h \
	src/google_breakpad/processor/static_contained_range_map.h \
	src/google_breakpad/processor/static_map_iterator-inl.h \
	src/google_breakpad/processor/static_map_iterator.h \
	src/google_breakpad/processor/static_map-inl.h \
	src/google_breakpad/processor/static_map.h \
	src/google_breakpad/processor/static_range_map-inl.h \
	src/google_breakpad/processor/static_range_map.h \
	src/google_breakpad/processor/symbolic_constants_win.cc \
	src/google_breakpad/processor/symbolic_constants_win.h \
	src/google_breakpad/processor/tokenize.cc \
	src/google_breakpad/processor/tokenize.h

src_third_party_libdisasm_libdisasm_a_SOURCES = \
	src/third_party/libdisasm/ia32_implicit.c \
	src/third_party/libdisasm/ia32_implicit.h \
	src/third_party/libdisasm/ia32_insn.c \
	src/third_party/libdisasm/ia32_insn.h \
	src/third_party/libdisasm/ia32_invariant.c \
	src/third_party/libdisasm/ia32_invariant.h \
	src/third_party/libdisasm/ia32_modrm.c \
	src/third_party/libdisasm/ia32_modrm.h \
	src/third_party/libdisasm/ia32_opcode_tables.c \
	src/third_party/libdisasm/ia32_opcode_tables.h \
	src/third_party/libdisasm/ia32_operand.c \
	src/third_party/libdisasm/ia32_operand.h \
	src/third_party/libdisasm/ia32_reg.c \
	src/third_party/libdisasm/ia32_reg.h \
	src/third_party/libdisasm/ia32_settings.c \
	src/third_party/libdisasm/ia32_settings.h \
	src/third_party/libdisasm/libdis.h \
	src/third_party/libdisasm/qword.h \
	src/third_party/libdisasm/x86_disasm.c \
	src/third_party/libdisasm/x86_format.c \
	src/third_party/libdisasm/x86_imm.c \
	src/third_party/libdisasm/x86_imm.h \
	src/third_party/libdisasm/x86_insn.c \
	src/third_party/libdisasm/x86_misc.c \
	src/third_party/libdisasm/x86_operand_list.c \
	src/third_party/libdisasm/x86_operand_list.h

## Programs
bin_PROGRAMS += \
	src/google_breakpad/processor/microdump_stackwalk \
	src/google_breakpad/processor/minidump_dump \
	src/google_breakpad/processor/minidump_stackwalk
endif !DISABLE_PROCESSOR

if LINUX_HOST
EXTRA_PROGRAMS += \
	src/google_breakpad/client/linux/linux_dumper_unittest_helper
CLEANFILES += \
	src/google_breakpad/client/linux/linux_dumper_unittest_helper

if !DISABLE_TOOLS
bin_PROGRAMS += \
	src/tools/linux/core2md/core2md \
	src/tools/linux/dump_syms/dump_syms \
	src/tools/linux/md2core/minidump-2-core \
	src/tools/linux/symupload/minidump_upload \
	src/tools/linux/symupload/sym_upload
if X86_HOST
bin_PROGRAMS += \
	src/tools/mac/dump_syms/dump_syms_mac
endif
endif
endif LINUX_HOST


## Tests
if !DISABLE_PROCESSOR
check_PROGRAMS += \
	src/google_breakpad/common/test_assembler_unittest \
	src/google_breakpad/processor/address_map_unittest \
	src/google_breakpad/processor/basic_source_line_resolver_unittest \
	src/google_breakpad/processor/cfi_frame_info_unittest \
	src/google_breakpad/processor/contained_range_map_unittest \
	src/google_breakpad/processor/disassembler_x86_unittest \
	src/google_breakpad/processor/exploitability_unittest \
	src/google_breakpad/processor/fast_source_line_resolver_unittest \
	src/google_breakpad/processor/map_serializers_unittest \
	src/google_breakpad/processor/microdump_processor_unittest \
	src/google_breakpad/processor/minidump_processor_unittest \
	src/google_breakpad/processor/minidump_unittest \
	src/google_breakpad/processor/static_address_map_unittest \
	src/google_breakpad/processor/static_contained_range_map_unittest \
	src/google_breakpad/processor/static_map_unittest \
	src/google_breakpad/processor/static_range_map_unittest \
	src/google_breakpad/processor/pathname_stripper_unittest \
	src/google_breakpad/processor/postfix_evaluator_unittest \
	src/google_breakpad/processor/proc_maps_linux_unittest \
	src/google_breakpad/processor/range_map_unittest \
	src/google_breakpad/processor/stackwalker_amd64_unittest \
	src/google_breakpad/processor/stackwalker_arm_unittest \
	src/google_breakpad/processor/stackwalker_arm64_unittest \
	src/google_breakpad/processor/stackwalker_address_list_unittest \
	src/google_breakpad/processor/stackwalker_mips_unittest \
	src/google_breakpad/processor/stackwalker_mips64_unittest \
	src/google_breakpad/processor/stackwalker_x86_unittest \
	src/google_breakpad/processor/synth_minidump_unittest
endif

if LINUX_HOST
EXTRA_PROGRAMS += \
	src/google_breakpad/client/linux/linux_client_unittest_shlib
CLEANFILES += \
	src/google_breakpad/client/linux/linux_client_unittest_shlib

check_PROGRAMS += \
	src/google_breakpad/client/linux/linux_client_unittest

if !DISABLE_TOOLS
check_PROGRAMS += \
	src/google_breakpad/common/dumper_unittest \
	src/tools/linux/md2core/minidump_2_core_unittest
if X86_HOST
check_PROGRAMS += \
	src/google_breakpad/common/mac/macho_reader_unittest
endif
endif
endif LINUX_HOST

if !DISABLE_PROCESSOR
if SELFTEST
check_PROGRAMS += \
	src/google_breakpad/processor/stackwalker_selftest
endif SELFTEST
endif !DISABLE_PROCESSOR

if !DISABLE_PROCESSOR
check_SCRIPTS = \
	src/google_breakpad/processor/microdump_stackwalk_test \
	src/google_breakpad/processor/microdump_stackwalk_machine_readable_test \
	src/google_breakpad/processor/minidump_dump_test \
	src/google_breakpad/processor/minidump_stackwalk_test \
	src/google_breakpad/processor/minidump_stackwalk_machine_readable_test
endif

TESTS = $(check_PROGRAMS) $(check_SCRIPTS)

if ANDROID_HOST
# Since Autotools 1.2, tests are run through a special "test driver" script.
# Unfortunately, it's not possible anymore to specify an alternative shell to
# run them on connected devices, so use a slightly modified version of the
# driver for Android.
LOG_DRIVER = $(top_srcdir)/android/test-driver
else
# The default Autotools test driver script.
LOG_DRIVER = $(top_srcdir)/autotools/test-driver
endif

if LINUX_HOST
src_google_breakpad_client_linux_linux_dumper_unittest_helper_SOURCES = \
	src/google_breakpad/client/linux/minidump_writer/linux_dumper_unittest_helper.cc
src_google_breakpad_client_linux_linux_dumper_unittest_helper_LDFLAGS=$(PTHREAD_CFLAGS)
src_google_breakpad_client_linux_linux_dumper_unittest_helper_CC=$(PTHREAD_CC)
if ANDROID_HOST
# On Android PTHREAD_CFLAGS is empty, and adding src/google_breakpad/common/android/include
# to the include path is necessary to build this program.
src_google_breakpad_client_linux_linux_dumper_unittest_helper_CXXFLAGS=$(AM_CXXFLAGS)
else
src_google_breakpad_client_linux_linux_dumper_unittest_helper_CXXFLAGS=$(PTHREAD_CFLAGS)
endif

src_google_breakpad_client_linux_linux_client_unittest_shlib_SOURCES = \
	$(src_testing_libtesting_a_SOURCES) \
	src/google_breakpad/client/linux/handler/exception_handler_unittest.cc \
	src/google_breakpad/client/linux/minidump_writer/directory_reader_unittest.cc \
	src/google_breakpad/client/linux/minidump_writer/cpu_set_unittest.cc \
	src/google_breakpad/client/linux/minidump_writer/line_reader_unittest.cc \
	src/google_breakpad/client/linux/minidump_writer/linux_core_dumper.cc \
	src/google_breakpad/client/linux/minidump_writer/linux_core_dumper_unittest.cc \
	src/google_breakpad/client/linux/minidump_writer/linux_ptrace_dumper_unittest.cc \
	src/google_breakpad/client/linux/minidump_writer/minidump_writer_unittest.cc \
	src/google_breakpad/client/linux/minidump_writer/minidump_writer_unittest_utils.cc \
	src/google_breakpad/client/linux/minidump_writer/proc_cpuinfo_reader_unittest.cc \
	src/google_breakpad/common/linux/elf_core_dump.cc \
	src/google_breakpad/common/linux/linux_libc_support_unittest.cc \
	src/google_breakpad/common/linux/tests/crash_generator.cc \
	src/google_breakpad/common/memory_unittest.cc \
	src/google_breakpad/common/tests/file_utils.cc \
	src/google_breakpad/processor/basic_code_modules.cc \
	src/google_breakpad/processor/dump_context.cc \
	src/google_breakpad/processor/dump_object.cc \
	src/google_breakpad/processor/logging.cc \
	src/google_breakpad/processor/minidump.cc \
	src/google_breakpad/processor/pathname_stripper.cc \
	src/google_breakpad/processor/proc_maps_linux.cc
if ANDROID_HOST
src_google_breakpad_client_linux_linux_client_unittest_shlib_SOURCES += \
	src/google_breakpad/common/android/breakpad_getcontext.S
endif
if LINUX_HOST
src_google_breakpad_client_linux_linux_client_unittest_shlib_SOURCES += \
	src/google_breakpad/client/linux/microdump_writer/microdump_writer_unittest.cc
endif

src_google_breakpad_client_linux_linux_client_unittest_shlib_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)
src_google_breakpad_client_linux_linux_client_unittest_shlib_LDFLAGS = \
	-shared \
	-Wl,-h,linux_client_unittest_shlib
src_google_breakpad_client_linux_linux_client_unittest_shlib_LDADD = \
	src/google_breakpad/client/linux/crash_generation/crash_generation_client.o \
	src/google_breakpad/client/linux/dump_writer_common/thread_info.o \
	src/google_breakpad/client/linux/dump_writer_common/ucontext_reader.o \
	src/google_breakpad/client/linux/handler/exception_handler.o \
	src/google_breakpad/client/linux/handler/minidump_descriptor.o \
	src/google_breakpad/client/linux/log/log.o \
	src/google_breakpad/client/linux/microdump_writer/microdump_writer.o \
	src/google_breakpad/client/linux/minidump_writer/linux_dumper.o \
	src/google_breakpad/client/linux/minidump_writer/linux_ptrace_dumper.o \
	src/google_breakpad/client/linux/minidump_writer/minidump_writer.o \
	src/google_breakpad/client/minidump_file_writer.o \
	src/google_breakpad/common/convert_UTF.o \
	src/google_breakpad/common/md5.o \
	src/google_breakpad/common/linux/elfutils.o \
	src/google_breakpad/common/linux/file_id.o \
	src/google_breakpad/common/linux/guid_creator.o \
	src/google_breakpad/common/linux/linux_libc_support.o \
	src/google_breakpad/common/linux/memory_mapped_file.o \
	src/google_breakpad/common/linux/safe_readlink.o \
	src/google_breakpad/common/string_conversion.o \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)
if ANDROID_HOST
src_google_breakpad_client_linux_linux_client_unittest_shlib_SOURCES += \
	src/google_breakpad/common/android/breakpad_getcontext_unittest.cc
src_google_breakpad_client_linux_linux_client_unittest_shlib_LDFLAGS += \
	-llog -lm
endif

src_google_breakpad_client_linux_linux_client_unittest_shlib_DEPENDENCIES = \
	src/google_breakpad/client/linux/linux_dumper_unittest_helper \
	src/google_breakpad/client/linux/libbreakpad_client.a \
	$(TEST_DEPS) \
	src/libbreakpad.a

src_google_breakpad_client_linux_linux_client_unittest_SOURCES =
# The extra-long build id is for a test in minidump_writer_unittest.cc.
src_google_breakpad_client_linux_linux_client_unittest_LDFLAGS = \
	-Wl,-rpath,'$$ORIGIN' \
	-Wl,--build-id=0x000102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f
if ANDROID_HOST
src_google_breakpad_client_linux_linux_client_unittest_LDFLAGS += \
        -llog
endif

src_google_breakpad_client_linux_linux_client_unittest_LDADD = \
	src/google_breakpad/client/linux/linux_client_unittest_shlib \
	$(TEST_LIBS)

src_google_breakpad_client_linux_linux_client_unittest_DEPENDENCIES = \
	src/google_breakpad/client/linux/linux_client_unittest_shlib

if !DISABLE_TOOLS
src_tools_linux_core2md_core2md_SOURCES = \
	src/tools/linux/core2md/core2md.cc

src_tools_linux_core2md_core2md_LDADD = \
	src/google_breakpad/client/linux/libbreakpad_client.a

src_tools_linux_dump_syms_dump_syms_SOURCES = \
	src/google_breakpad/common/dwarf_cfi_to_module.cc \
	src/google_breakpad/common/dwarf_cu_to_module.cc \
	src/google_breakpad/common/dwarf_line_to_module.cc \
	src/google_breakpad/common/language.cc \
	src/google_breakpad/common/module.cc \
	src/google_breakpad/common/stabs_reader.cc \
	src/google_breakpad/common/stabs_to_module.cc \
	src/google_breakpad/common/dwarf/bytereader.cc \
	src/google_breakpad/common/dwarf/dwarf2diehandler.cc \
	src/google_breakpad/common/dwarf/dwarf2reader.cc \
	src/google_breakpad/common/linux/crc32.cc \
	src/google_breakpad/common/linux/dump_symbols.cc \
	src/google_breakpad/common/linux/elf_symbols_to_module.cc \
	src/google_breakpad/common/linux/elfutils.cc \
	src/google_breakpad/common/linux/file_id.cc \
	src/google_breakpad/common/linux/linux_libc_support.cc \
	src/google_breakpad/common/linux/memory_mapped_file.cc \
	src/google_breakpad/common/linux/safe_readlink.cc \
	src/tools/linux/dump_syms/dump_syms.cc

src_tools_linux_md2core_minidump_2_core_SOURCES = \
	src/google_breakpad/common/linux/memory_mapped_file.cc \
	src/tools/linux/md2core/minidump-2-core.cc

src_tools_linux_symupload_minidump_upload_SOURCES = \
	src/google_breakpad/common/linux/http_upload.cc \
	src/tools/linux/symupload/minidump_upload.cc
src_tools_linux_symupload_minidump_upload_LDADD = -ldl

src_tools_linux_symupload_sym_upload_SOURCES = \
	src/google_breakpad/common/linux/http_upload.cc \
	src/google_breakpad/common/linux/symbol_upload.cc \
	src/tools/linux/symupload/sym_upload.cc
src_tools_linux_symupload_sym_upload_LDADD = -ldl

src_tools_mac_dump_syms_dump_syms_mac_SOURCES = \
	src/google_breakpad/common/dwarf_cfi_to_module.cc \
	src/google_breakpad/common/dwarf_cu_to_module.cc \
	src/google_breakpad/common/dwarf_line_to_module.cc \
	src/google_breakpad/common/language.cc \
	src/google_breakpad/common/md5.cc \
	src/google_breakpad/common/module.cc \
	src/google_breakpad/common/stabs_reader.cc \
	src/google_breakpad/common/stabs_to_module.cc \
	src/google_breakpad/common/dwarf/bytereader.cc \
	src/google_breakpad/common/dwarf/dwarf2diehandler.cc \
	src/google_breakpad/common/dwarf/dwarf2reader.cc \
	src/google_breakpad/common/mac/arch_utilities.cc \
	src/google_breakpad/common/mac/dump_syms.cc \
	src/google_breakpad/common/mac/file_id.cc \
	src/google_breakpad/common/mac/macho_id.cc \
	src/google_breakpad/common/mac/macho_reader.cc \
	src/google_breakpad/common/mac/macho_utilities.cc \
	src/google_breakpad/common/mac/macho_walker.cc \
	src/tools/mac/dump_syms/dump_syms_tool.cc
src_tools_mac_dump_syms_dump_syms_mac_CXXFLAGS= \
	-I$(top_srcdir)/src/third_party/mac_headers \
	-DHAVE_MACH_O_NLIST_H

src_google_breakpad_common_dumper_unittest_SOURCES = \
	src/google_breakpad/common/byte_cursor_unittest.cc \
	src/google_breakpad/common/dwarf_cfi_to_module.cc \
	src/google_breakpad/common/dwarf_cfi_to_module_unittest.cc \
	src/google_breakpad/common/dwarf_cu_to_module.cc \
	src/google_breakpad/common/dwarf_cu_to_module_unittest.cc \
	src/google_breakpad/common/dwarf_line_to_module.cc \
	src/google_breakpad/common/dwarf_line_to_module_unittest.cc \
	src/google_breakpad/common/language.cc \
	src/google_breakpad/common/memory_range_unittest.cc \
	src/google_breakpad/common/module.cc \
	src/google_breakpad/common/module_unittest.cc \
	src/google_breakpad/common/stabs_reader.cc \
	src/google_breakpad/common/stabs_reader_unittest.cc \
	src/google_breakpad/common/stabs_to_module.cc \
	src/google_breakpad/common/stabs_to_module_unittest.cc \
	src/google_breakpad/common/test_assembler.cc \
	src/google_breakpad/common/dwarf/bytereader.cc \
	src/google_breakpad/common/dwarf/bytereader_unittest.cc \
	src/google_breakpad/common/dwarf/cfi_assembler.cc \
	src/google_breakpad/common/dwarf/dwarf2diehandler.cc \
	src/google_breakpad/common/dwarf/dwarf2diehandler_unittest.cc \
	src/google_breakpad/common/dwarf/dwarf2reader.cc \
	src/google_breakpad/common/dwarf/dwarf2reader_cfi_unittest.cc \
	src/google_breakpad/common/dwarf/dwarf2reader_die_unittest.cc \
	src/google_breakpad/common/linux/crc32.cc \
	src/google_breakpad/common/linux/dump_symbols.cc \
	src/google_breakpad/common/linux/dump_symbols_unittest.cc \
	src/google_breakpad/common/linux/elf_core_dump.cc \
	src/google_breakpad/common/linux/elf_core_dump_unittest.cc \
	src/google_breakpad/common/linux/elf_symbols_to_module.cc \
	src/google_breakpad/common/linux/elf_symbols_to_module_unittest.cc \
	src/google_breakpad/common/linux/elfutils.cc \
	src/google_breakpad/common/linux/file_id.cc \
	src/google_breakpad/common/linux/file_id_unittest.cc \
	src/google_breakpad/common/linux/linux_libc_support.cc \
	src/google_breakpad/common/linux/memory_mapped_file.cc \
	src/google_breakpad/common/linux/memory_mapped_file_unittest.cc \
	src/google_breakpad/common/linux/safe_readlink.cc \
	src/google_breakpad/common/linux/safe_readlink_unittest.cc \
	src/google_breakpad/common/linux/synth_elf.cc \
	src/google_breakpad/common/linux/synth_elf_unittest.cc \
	src/google_breakpad/common/linux/tests/crash_generator.cc \
	src/google_breakpad/common/tests/file_utils.cc
src_google_breakpad_common_dumper_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS) \
	$(PTHREAD_CFLAGS)
src_google_breakpad_common_dumper_unittest_LDADD = \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)

src_google_breakpad_common_mac_macho_reader_unittest_SOURCES = \
	src/google_breakpad/common/dwarf_cfi_to_module.cc \
	src/google_breakpad/common/dwarf_cu_to_module.cc \
	src/google_breakpad/common/dwarf_line_to_module.cc \
	src/google_breakpad/common/language.cc \
	src/google_breakpad/common/md5.cc \
	src/google_breakpad/common/module.cc \
	src/google_breakpad/common/stabs_reader.cc \
	src/google_breakpad/common/stabs_to_module.cc \
	src/google_breakpad/common/test_assembler.cc \
	src/google_breakpad/common/dwarf/bytereader.cc \
	src/google_breakpad/common/dwarf/cfi_assembler.cc \
	src/google_breakpad/common/dwarf/dwarf2diehandler.cc \
	src/google_breakpad/common/dwarf/dwarf2reader.cc \
	src/google_breakpad/common/mac/arch_utilities.cc \
	src/google_breakpad/common/mac/file_id.cc \
	src/google_breakpad/common/mac/macho_id.cc \
	src/google_breakpad/common/mac/macho_reader.cc \
	src/google_breakpad/common/mac/macho_reader_unittest.cc \
	src/google_breakpad/common/mac/macho_utilities.cc \
	src/google_breakpad/common/mac/macho_walker.cc \
	src/google_breakpad/common/tests/file_utils.cc
src_google_breakpad_common_mac_macho_reader_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS) \
	-I$(top_srcdir)/src/third_party/mac_headers \
	-DHAVE_MACH_O_NLIST_H \
	$(PTHREAD_CFLAGS)
src_google_breakpad_common_mac_macho_reader_unittest_LDADD = \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)
endif

src_tools_linux_md2core_minidump_2_core_unittest_SOURCES = \
	src/tools/linux/md2core/minidump_memory_range_unittest.cc
src_tools_linux_md2core_minidump_2_core_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)
src_tools_linux_md2core_minidump_2_core_unittest_LDADD = \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)

endif LINUX_HOST

if !DISABLE_PROCESSOR
src_google_breakpad_processor_address_map_unittest_SOURCES = \
	src/google_breakpad/processor/address_map_unittest.cc
src_google_breakpad_processor_address_map_unittest_LDADD = \
	src/google_breakpad/processor/logging.o \
	src/google_breakpad/processor/pathname_stripper.o

src_google_breakpad_processor_basic_source_line_resolver_unittest_SOURCES = \
	src/google_breakpad/processor/basic_source_line_resolver_unittest.cc
src_google_breakpad_processor_basic_source_line_resolver_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)
src_google_breakpad_processor_basic_source_line_resolver_unittest_LDADD = \
	src/google_breakpad/processor/basic_source_line_resolver.o \
	src/google_breakpad/processor/cfi_frame_info.o \
	src/google_breakpad/processor/pathname_stripper.o \
	src/google_breakpad/processor/logging.o \
	src/google_breakpad/processor/source_line_resolver_base.o \
	src/google_breakpad/processor/tokenize.o \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)

src_google_breakpad_processor_cfi_frame_info_unittest_SOURCES = \
	src/google_breakpad/processor/cfi_frame_info_unittest.cc
src_google_breakpad_processor_cfi_frame_info_unittest_LDADD = \
	src/google_breakpad/processor/cfi_frame_info.o \
	src/google_breakpad/processor/logging.o \
	src/google_breakpad/processor/pathname_stripper.o \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)
src_google_breakpad_processor_cfi_frame_info_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)

src_google_breakpad_processor_contained_range_map_unittest_SOURCES = \
	src/google_breakpad/processor/contained_range_map_unittest.cc
src_google_breakpad_processor_contained_range_map_unittest_LDADD = \
	src/google_breakpad/processor/logging.o \
	src/google_breakpad/processor/pathname_stripper.o

src_google_breakpad_processor_exploitability_unittest_SOURCES = \
	src/google_breakpad/processor/exploitability_unittest.cc
src_google_breakpad_processor_exploitability_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)
src_google_breakpad_processor_exploitability_unittest_LDADD = \
	src/google_breakpad/processor/minidump_processor.o \
	src/google_breakpad/processor/process_state.o \
	src/google_breakpad/processor/disassembler_x86.o \
	src/google_breakpad/processor/exploitability.o \
	src/google_breakpad/processor/exploitability_linux.o \
	src/google_breakpad/processor/exploitability_win.o \
	src/google_breakpad/processor/basic_code_modules.o \
	src/google_breakpad/processor/basic_source_line_resolver.o \
	src/google_breakpad/processor/call_stack.o \
	src/google_breakpad/processor/cfi_frame_info.o \
	src/google_breakpad/processor/dump_context.o \
	src/google_breakpad/processor/dump_object.o \
	src/google_breakpad/processor/logging.o \
	src/google_breakpad/processor/minidump.o \
	src/google_breakpad/processor/pathname_stripper.o \
	src/google_breakpad/processor/proc_maps_linux.o \
	src/google_breakpad/processor/simple_symbol_supplier.o \
	src/google_breakpad/processor/source_line_resolver_base.o \
	src/google_breakpad/processor/stack_frame_cpu.o \
	src/google_breakpad/processor/stack_frame_symbolizer.o \
	src/google_breakpad/processor/stackwalker.o \
	src/google_breakpad/processor/stackwalker_address_list.o \
	src/google_breakpad/processor/stackwalker_amd64.o \
	src/google_breakpad/processor/stackwalker_arm.o \
	src/google_breakpad/processor/stackwalker_arm64.o \
	src/google_breakpad/processor/stackwalker_mips.o \
	src/google_breakpad/processor/stackwalker_ppc.o \
	src/google_breakpad/processor/stackwalker_ppc64.o \
	src/google_breakpad/processor/stackwalker_sparc.o \
	src/google_breakpad/processor/stackwalker_x86.o \
	src/google_breakpad/processor/symbolic_constants_win.o \
	src/google_breakpad/processor/tokenize.o \
	src/third_party/libdisasm/libdisasm.a \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)

src_google_breakpad_processor_disassembler_x86_unittest_SOURCES = \
	src/google_breakpad/processor/disassembler_x86_unittest.cc
src_google_breakpad_processor_disassembler_x86_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)
src_google_breakpad_processor_disassembler_x86_unittest_LDADD = \
	src/google_breakpad/processor/disassembler_x86.o \
	src/third_party/libdisasm/libdisasm.a \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)

src_google_breakpad_processor_fast_source_line_resolver_unittest_SOURCES = \
	src/google_breakpad/processor/fast_source_line_resolver_unittest.cc
src_google_breakpad_processor_fast_source_line_resolver_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)
src_google_breakpad_processor_fast_source_line_resolver_unittest_LDADD = \
	src/google_breakpad/processor/fast_source_line_resolver.o \
	src/google_breakpad/processor/basic_source_line_resolver.o \
	src/google_breakpad/processor/cfi_frame_info.o \
	src/google_breakpad/processor/module_comparer.o \
	src/google_breakpad/processor/module_serializer.o \
	src/google_breakpad/processor/pathname_stripper.o \
	src/google_breakpad/processor/logging.o \
	src/google_breakpad/processor/source_line_resolver_base.o \
	src/google_breakpad/processor/tokenize.o \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)

src_google_breakpad_processor_map_serializers_unittest_SOURCES = \
	src/google_breakpad/processor/map_serializers_unittest.cc
src_google_breakpad_processor_map_serializers_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)
src_google_breakpad_processor_map_serializers_unittest_LDADD = \
	src/google_breakpad/processor/logging.o \
	src/google_breakpad/processor/pathname_stripper.o \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)

src_google_breakpad_processor_microdump_processor_unittest_SOURCES = \
	src/google_breakpad/processor/microdump_processor_unittest.cc
src_google_breakpad_processor_microdump_processor_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)
src_google_breakpad_processor_microdump_processor_unittest_LDADD = \
	src/google_breakpad/processor/basic_code_modules.o \
	src/google_breakpad/processor/basic_source_line_resolver.o \
	src/google_breakpad/processor/call_stack.o \
	src/google_breakpad/processor/cfi_frame_info.o \
	src/google_breakpad/processor/dump_context.o \
	src/google_breakpad/processor/dump_object.o \
	src/google_breakpad/processor/logging.o \
	src/google_breakpad/processor/microdump.o \
	src/google_breakpad/processor/microdump_processor.o \
	src/google_breakpad/processor/pathname_stripper.o \
	src/google_breakpad/processor/process_state.o \
	src/google_breakpad/processor/simple_symbol_supplier.o \
	src/google_breakpad/processor/source_line_resolver_base.o \
	src/google_breakpad/processor/stack_frame_symbolizer.o \
	src/google_breakpad/processor/stackwalker.o \
	src/google_breakpad/processor/stackwalker_address_list.o \
	src/google_breakpad/processor/stackwalker_amd64.o \
	src/google_breakpad/processor/stackwalker_arm.o \
	src/google_breakpad/processor/stackwalker_arm64.o \
	src/google_breakpad/processor/stackwalker_mips.o \
	src/google_breakpad/processor/stackwalker_ppc.o \
	src/google_breakpad/processor/stackwalker_ppc64.o \
	src/google_breakpad/processor/stackwalker_sparc.o \
	src/google_breakpad/processor/stackwalker_x86.o \
	src/google_breakpad/processor/tokenize.o \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)

src_google_breakpad_processor_minidump_processor_unittest_SOURCES = \
	src/google_breakpad/processor/minidump_processor_unittest.cc
src_google_breakpad_processor_minidump_processor_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)
src_google_breakpad_processor_minidump_processor_unittest_LDADD = \
	src/google_breakpad/processor/basic_code_modules.o \
	src/google_breakpad/processor/basic_source_line_resolver.o \
	src/google_breakpad/processor/call_stack.o \
	src/google_breakpad/processor/cfi_frame_info.o \
	src/google_breakpad/processor/disassembler_x86.o \
	src/google_breakpad/processor/dump_context.o \
	src/google_breakpad/processor/dump_object.o \
	src/google_breakpad/processor/exploitability.o \
	src/google_breakpad/processor/exploitability_linux.o \
	src/google_breakpad/processor/exploitability_win.o \
	src/google_breakpad/processor/logging.o \
	src/google_breakpad/processor/minidump_processor.o \
	src/google_breakpad/processor/minidump.o \
	src/google_breakpad/processor/pathname_stripper.o \
	src/google_breakpad/processor/process_state.o \
	src/google_breakpad/processor/proc_maps_linux.o \
	src/google_breakpad/processor/source_line_resolver_base.o \
	src/google_breakpad/processor/stack_frame_cpu.o \
	src/google_breakpad/processor/stack_frame_symbolizer.o \
	src/google_breakpad/processor/stackwalker.o \
	src/google_breakpad/processor/stackwalker_address_list.o \
	src/google_breakpad/processor/stackwalker_amd64.o \
	src/google_breakpad/processor/stackwalker_arm.o \
	src/google_breakpad/processor/stackwalker_arm64.o \
	src/google_breakpad/processor/stackwalker_mips.o \
	src/google_breakpad/processor/stackwalker_ppc.o \
	src/google_breakpad/processor/stackwalker_ppc64.o \
	src/google_breakpad/processor/stackwalker_sparc.o \
	src/google_breakpad/processor/stackwalker_x86.o \
	src/google_breakpad/processor/symbolic_constants_win.o \
	src/google_breakpad/processor/tokenize.o \
	src/third_party/libdisasm/libdisasm.a \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)

src_google_breakpad_processor_minidump_unittest_SOURCES = \
	src/google_breakpad/common/test_assembler.cc \
	src/google_breakpad/processor/minidump_unittest.cc \
	src/google_breakpad/processor/synth_minidump.cc
src_google_breakpad_processor_minidump_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)
src_google_breakpad_processor_minidump_unittest_LDADD = \
	src/google_breakpad/processor/basic_code_modules.o \
	src/google_breakpad/processor/dump_context.o \
	src/google_breakpad/processor/dump_object.o \
	src/google_breakpad/processor/logging.o \
	src/google_breakpad/processor/minidump.o \
	src/google_breakpad/processor/pathname_stripper.o \
	src/google_breakpad/processor/proc_maps_linux.o \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)

src_google_breakpad_processor_proc_maps_linux_unittest_SOURCES = \
	src/google_breakpad/processor/proc_maps_linux.cc \
	src/google_breakpad/processor/proc_maps_linux_unittest.cc
src_google_breakpad_processor_proc_maps_linux_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)
src_google_breakpad_processor_proc_maps_linux_unittest_LDADD = \
	src/google_breakpad/processor/logging.o \
	src/google_breakpad/processor/pathname_stripper.o \
	src/third_party/libdisasm/libdisasm.a \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)

src_google_breakpad_processor_static_address_map_unittest_SOURCES = \
	src/google_breakpad/processor/static_address_map_unittest.cc
src_google_breakpad_processor_static_address_map_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)
src_google_breakpad_processor_static_address_map_unittest_LDADD = \
	src/google_breakpad/processor/logging.o \
	src/google_breakpad/processor/pathname_stripper.o \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)

src_google_breakpad_processor_static_contained_range_map_unittest_SOURCES = \
	src/google_breakpad/processor/static_contained_range_map_unittest.cc
src_google_breakpad_processor_static_contained_range_map_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)
src_google_breakpad_processor_static_contained_range_map_unittest_LDADD = \
	src/google_breakpad/processor/logging.o \
	src/google_breakpad/processor/pathname_stripper.o \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)

src_google_breakpad_processor_static_map_unittest_SOURCES = \
	src/google_breakpad/processor/static_map_unittest.cc
src_google_breakpad_processor_static_map_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)
src_google_breakpad_processor_static_map_unittest_LDADD = \
	src/google_breakpad/processor/logging.o \
	src/google_breakpad/processor/pathname_stripper.o \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)

src_google_breakpad_processor_static_range_map_unittest_SOURCES = \
	src/google_breakpad/processor/static_range_map_unittest.cc
src_google_breakpad_processor_static_range_map_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)
src_google_breakpad_processor_static_range_map_unittest_LDADD = \
	src/google_breakpad/processor/logging.o \
	src/google_breakpad/processor/pathname_stripper.o \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)

src_google_breakpad_processor_pathname_stripper_unittest_SOURCES = \
	src/google_breakpad/processor/pathname_stripper_unittest.cc
src_google_breakpad_processor_pathname_stripper_unittest_LDADD = \
	src/google_breakpad/processor/pathname_stripper.o \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)

src_google_breakpad_processor_postfix_evaluator_unittest_SOURCES = \
	src/google_breakpad/processor/postfix_evaluator_unittest.cc
src_google_breakpad_processor_postfix_evaluator_unittest_LDADD = \
	src/google_breakpad/processor/logging.o \
	src/google_breakpad/processor/pathname_stripper.o \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)

src_google_breakpad_processor_range_map_unittest_SOURCES = \
	src/google_breakpad/processor/range_map_unittest.cc
src_google_breakpad_processor_range_map_unittest_LDADD = \
	src/google_breakpad/processor/logging.o \
	src/google_breakpad/processor/pathname_stripper.o \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)

src_google_breakpad_processor_stackwalker_selftest_SOURCES = \
	src/google_breakpad/processor/stackwalker_selftest.cc
src_google_breakpad_processor_stackwalker_selftest_LDADD = \
	src/google_breakpad/processor/basic_code_modules.o \
	src/google_breakpad/processor/basic_source_line_resolver.o \
	src/google_breakpad/processor/call_stack.o \
	src/google_breakpad/processor/disassembler_x86.o \
	src/google_breakpad/processor/exploitability.o \
	src/google_breakpad/processor/exploitability_linux.o \
	src/google_breakpad/processor/exploitability_win.o \
	src/google_breakpad/processor/logging.o \
	src/google_breakpad/processor/minidump.o \
	src/google_breakpad/processor/pathname_stripper.o \
	src/google_breakpad/processor/proc_maps_linux.o \
	src/google_breakpad/processor/source_line_resolver_base.o \
	src/google_breakpad/processor/stack_frame_cpu.o \
	src/google_breakpad/processor/stack_frame_symbolizer.o \
	src/google_breakpad/processor/stackwalker.o \
	src/google_breakpad/processor/stackwalker_address_list.o \
	src/google_breakpad/processor/stackwalker_amd64.o \
	src/google_breakpad/processor/stackwalker_arm.o \
	src/google_breakpad/processor/stackwalker_arm64.o \
	src/google_breakpad/processor/stackwalker_mips.o \
	src/google_breakpad/processor/stackwalker_ppc.o \
	src/google_breakpad/processor/stackwalker_ppc64.o \
	src/google_breakpad/processor/stackwalker_sparc.o \
	src/google_breakpad/processor/stackwalker_x86.o \
	src/google_breakpad/processor/tokenize.o \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)

src_google_breakpad_processor_stackwalker_amd64_unittest_SOURCES = \
	src/google_breakpad/common/test_assembler.cc \
	src/google_breakpad/processor/stackwalker_amd64_unittest.cc
src_google_breakpad_processor_stackwalker_amd64_unittest_LDADD = \
	src/libbreakpad.a \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)
src_google_breakpad_processor_stackwalker_amd64_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)

src_google_breakpad_processor_stackwalker_arm_unittest_SOURCES = \
	src/google_breakpad/common/test_assembler.cc \
	src/google_breakpad/processor/stackwalker_arm_unittest.cc
src_google_breakpad_processor_stackwalker_arm_unittest_LDADD = \
	src/libbreakpad.a \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)
src_google_breakpad_processor_stackwalker_arm_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)

src_google_breakpad_processor_stackwalker_arm64_unittest_SOURCES = \
	src/google_breakpad/common/test_assembler.cc \
	src/google_breakpad/processor/stackwalker_arm64_unittest.cc
src_google_breakpad_processor_stackwalker_arm64_unittest_LDADD = \
	src/libbreakpad.a \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)
src_google_breakpad_processor_stackwalker_arm64_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)

src_google_breakpad_processor_stackwalker_address_list_unittest_SOURCES = \
	src/google_breakpad/common/test_assembler.cc \
	src/google_breakpad/processor/stackwalker_address_list_unittest.cc
src_google_breakpad_processor_stackwalker_address_list_unittest_LDADD = \
	src/libbreakpad.a \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)
src_google_breakpad_processor_stackwalker_address_list_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)

src_google_breakpad_processor_stackwalker_mips_unittest_SOURCES = \
	src/google_breakpad/common/test_assembler.cc \
	src/google_breakpad/processor/stackwalker_mips_unittest.cc
src_google_breakpad_processor_stackwalker_mips_unittest_LDADD = \
	src/libbreakpad.a \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)
src_google_breakpad_processor_stackwalker_mips_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)

src_google_breakpad_processor_stackwalker_mips64_unittest_SOURCES = \
	src/google_breakpad/common/test_assembler.cc \
	src/google_breakpad/processor/stackwalker_mips64_unittest.cc
src_google_breakpad_processor_stackwalker_mips64_unittest_LDADD = \
	src/libbreakpad.a \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)
src_google_breakpad_processor_stackwalker_mips64_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)

src_google_breakpad_processor_stackwalker_x86_unittest_SOURCES = \
	src/google_breakpad/common/test_assembler.cc \
	src/google_breakpad/processor/stackwalker_x86_unittest.cc
src_google_breakpad_processor_stackwalker_x86_unittest_LDADD = \
	src/libbreakpad.a \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)
src_google_breakpad_processor_stackwalker_x86_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)

src_google_breakpad_processor_synth_minidump_unittest_SOURCES = \
	src/google_breakpad/common/test_assembler.cc \
	src/google_breakpad/common/test_assembler.h \
	src/google_breakpad/processor/synth_minidump_unittest.cc \
	src/google_breakpad/processor/synth_minidump.cc \
	src/google_breakpad/processor/synth_minidump.h
src_google_breakpad_processor_synth_minidump_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)
src_google_breakpad_processor_synth_minidump_unittest_LDADD = \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)

src_google_breakpad_common_test_assembler_unittest_SOURCES = \
	src/google_breakpad/common/test_assembler.cc \
	src/google_breakpad/common/test_assembler.h \
	src/google_breakpad/common/test_assembler_unittest.cc
src_google_breakpad_common_test_assembler_unittest_CPPFLAGS = \
	$(AM_CPPFLAGS) $(TEST_CFLAGS)
src_google_breakpad_common_test_assembler_unittest_LDADD = \
	$(TEST_LIBS) \
	$(PTHREAD_CFLAGS) $(PTHREAD_LIBS)

## Non-installables
noinst_PROGRAMS =
noinst_SCRIPTS = $(check_SCRIPTS)

src_google_breakpad_processor_minidump_dump_SOURCES = \
	src/google_breakpad/processor/minidump_dump.cc
src_google_breakpad_processor_minidump_dump_LDADD = \
	src/google_breakpad/processor/basic_code_modules.o \
	src/google_breakpad/processor/dump_context.o \
	src/google_breakpad/processor/dump_object.o \
	src/google_breakpad/processor/logging.o \
	src/google_breakpad/processor/minidump.o \
	src/google_breakpad/processor/pathname_stripper.o \
	src/google_breakpad/processor/proc_maps_linux.o

src_google_breakpad_processor_microdump_stackwalk_SOURCES = \
	src/google_breakpad/processor/microdump_stackwalk.cc
src_google_breakpad_processor_microdump_stackwalk_LDADD = \
	src/google_breakpad/processor/basic_code_modules.o \
	src/google_breakpad/processor/basic_source_line_resolver.o \
	src/google_breakpad/processor/call_stack.o \
	src/google_breakpad/processor/cfi_frame_info.o \
	src/google_breakpad/processor/disassembler_x86.o \
	src/google_breakpad/processor/dump_context.o \
	src/google_breakpad/processor/dump_object.o \
	src/google_breakpad/processor/logging.o \
	src/google_breakpad/processor/microdump.o \
	src/google_breakpad/processor/microdump_processor.o \
	src/google_breakpad/processor/pathname_stripper.o \
	src/google_breakpad/processor/process_state.o \
	src/google_breakpad/processor/simple_symbol_supplier.o \
	src/google_breakpad/processor/source_line_resolver_base.o \
	src/google_breakpad/processor/stack_frame_cpu.o \
	src/google_breakpad/processor/stack_frame_symbolizer.o \
	src/google_breakpad/processor/stackwalk_common.o \
	src/google_breakpad/processor/stackwalker.o \
	src/google_breakpad/processor/stackwalker_address_list.o \
	src/google_breakpad/processor/stackwalker_amd64.o \
	src/google_breakpad/processor/stackwalker_arm.o \
	src/google_breakpad/processor/stackwalker_arm64.o \
	src/google_breakpad/processor/stackwalker_mips.o \
	src/google_breakpad/processor/stackwalker_ppc.o \
	src/google_breakpad/processor/stackwalker_ppc64.o \
	src/google_breakpad/processor/stackwalker_sparc.o \
	src/google_breakpad/processor/stackwalker_x86.o \
	src/google_breakpad/processor/tokenize.o \
	src/third_party/libdisasm/libdisasm.a

src_google_breakpad_processor_minidump_stackwalk_SOURCES = \
	src/google_breakpad/processor/minidump_stackwalk.cc
src_google_breakpad_processor_minidump_stackwalk_LDADD = \
	src/google_breakpad/processor/basic_code_modules.o \
	src/google_breakpad/processor/basic_source_line_resolver.o \
	src/google_breakpad/processor/call_stack.o \
	src/google_breakpad/processor/cfi_frame_info.o \
	src/google_breakpad/processor/disassembler_x86.o \
	src/google_breakpad/processor/dump_context.o \
	src/google_breakpad/processor/dump_object.o \
	src/google_breakpad/processor/exploitability.o \
	src/google_breakpad/processor/exploitability_linux.o \
	src/google_breakpad/processor/exploitability_win.o \
	src/google_breakpad/processor/logging.o \
	src/google_breakpad/processor/minidump.o \
	src/google_breakpad/processor/minidump_processor.o \
	src/google_breakpad/processor/pathname_stripper.o \
	src/google_breakpad/processor/process_state.o \
	src/google_breakpad/processor/proc_maps_linux.o \
	src/google_breakpad/processor/simple_symbol_supplier.o \
	src/google_breakpad/processor/source_line_resolver_base.o \
	src/google_breakpad/processor/stack_frame_cpu.o \
	src/google_breakpad/processor/stack_frame_symbolizer.o \
	src/google_breakpad/processor/stackwalk_common.o \
	src/google_breakpad/processor/stackwalker.o \
	src/google_breakpad/processor/stackwalker_address_list.o \
	src/google_breakpad/processor/stackwalker_amd64.o \
	src/google_breakpad/processor/stackwalker_arm.o \
	src/google_breakpad/processor/stackwalker_arm64.o \
	src/google_breakpad/processor/stackwalker_mips.o \
	src/google_breakpad/processor/stackwalker_ppc.o \
	src/google_breakpad/processor/stackwalker_ppc64.o \
	src/google_breakpad/processor/stackwalker_sparc.o \
	src/google_breakpad/processor/stackwalker_x86.o \
	src/google_breakpad/processor/symbolic_constants_win.o \
	src/google_breakpad/processor/tokenize.o \
	src/third_party/libdisasm/libdisasm.a

endif !DISABLE_PROCESSOR

## Additional files to be included in a source distribution
##
## find src/client src/common src/google_breakpad/processor/testdata src/tools \
##     -type f \! -path '*/.svn/*' -print | sort | \
##     sed -e s/'^\(.*\)$'/'\t\1 \\'/
EXTRA_DIST = \
	$(SCRIPTS) \
	src/google_breakpad/processor/stackwalk_selftest_sol.s \
	src/google_breakpad/client/linux/handler/Makefile \
	src/google_breakpad/client/linux/handler/exception_handler.cc \
	src/google_breakpad/client/linux/handler/exception_handler.h \
	src/google_breakpad/client/linux/handler/minidump_descriptor.cc \
	src/google_breakpad/client/linux/handler/minidump_descriptor.h \
	src/google_breakpad/client/linux/handler/exception_handler_test.cc \
	src/google_breakpad/client/linux/handler/linux_thread.cc \
	src/google_breakpad/client/linux/handler/linux_thread.h \
	src/google_breakpad/client/linux/handler/linux_thread_test.cc \
	src/google_breakpad/client/linux/handler/minidump_generator.cc \
	src/google_breakpad/client/linux/handler/minidump_generator.h \
	src/google_breakpad/client/linux/handler/minidump_test.cc \
	src/google_breakpad/client/mac/handler/dynamic_images.cc \
	src/google_breakpad/client/mac/handler/dynamic_images.h \
	src/google_breakpad/client/mac/handler/exception_handler.cc \
	src/google_breakpad/client/mac/handler/exception_handler.h \
	src/google_breakpad/client/mac/handler/exception_handler_test.cc \
	src/google_breakpad/client/mac/handler/minidump_generator.cc \
	src/google_breakpad/client/mac/handler/minidump_generator.h \
	src/google_breakpad/client/mac/handler/minidump_generator_test.cc \
	src/google_breakpad/client/mac/handler/minidump_test.xcodeproj/project.pbxproj \
	src/google_breakpad/client/mac/handler/protected_memory_allocator.cc \
	src/google_breakpad/client/mac/handler/protected_memory_allocator.h \
	src/google_breakpad/client/minidump_file_writer-inl.h \
	src/google_breakpad/client/minidump_file_writer.cc \
	src/google_breakpad/client/minidump_file_writer.h \
	src/google_breakpad/client/minidump_file_writer_unittest.cc \
	src/google_breakpad/client/solaris/handler/Makefile \
	src/google_breakpad/client/solaris/handler/exception_handler.cc \
	src/google_breakpad/client/solaris/handler/exception_handler.h \
	src/google_breakpad/client/solaris/handler/exception_handler_test.cc \
	src/google_breakpad/client/solaris/handler/minidump_generator.cc \
	src/google_breakpad/client/solaris/handler/minidump_generator.h \
	src/google_breakpad/client/solaris/handler/minidump_test.cc \
	src/google_breakpad/client/solaris/handler/solaris_lwp.cc \
	src/google_breakpad/client/solaris/handler/solaris_lwp.h \
	src/google_breakpad/client/windows/breakpad_client.sln \
	src/google_breakpad/client/windows/handler/exception_handler.cc \
	src/google_breakpad/client/windows/handler/exception_handler.h \
	src/google_breakpad/client/windows/handler/exception_handler.vcproj \
	src/google_breakpad/client/windows/sender/crash_report_sender.cc \
	src/google_breakpad/client/windows/sender/crash_report_sender.h \
	src/google_breakpad/client/windows/sender/crash_report_sender.vcproj \
	src/google_breakpad/common/convert_UTF.cc \
	src/google_breakpad/common/convert_UTF.h \
	src/google_breakpad/common/linux/crc32.cc \
	src/google_breakpad/common/linux/dump_symbols.cc \
	src/google_breakpad/common/linux/dump_symbols.h \
	src/google_breakpad/common/linux/elf_symbols_to_module.cc \
	src/google_breakpad/common/linux/elf_symbols_to_module.h \
	src/google_breakpad/common/linux/elfutils.cc \
	src/google_breakpad/common/linux/elfutils.h \
	src/google_breakpad/common/linux/file_id.cc \
	src/google_breakpad/common/linux/file_id.h \
	src/google_breakpad/common/linux/guid_creator.cc \
	src/google_breakpad/common/linux/guid_creator.h \
	src/google_breakpad/common/linux/http_upload.cc \
	src/google_breakpad/common/linux/http_upload.h \
	src/google_breakpad/common/linux/symbol_upload.cc \
	src/google_breakpad/common/linux/symbol_upload.h \
	src/google_breakpad/common/mac/HTTPMultipartUpload.h \
	src/google_breakpad/common/mac/HTTPMultipartUpload.m \
	src/google_breakpad/common/mac/dump_syms.h \
	src/google_breakpad/common/mac/dump_syms.cc \
	src/google_breakpad/common/mac/file_id.cc \
	src/google_breakpad/common/mac/file_id.h \
	src/google_breakpad/common/mac/macho_id.cc \
	src/google_breakpad/common/mac/macho_id.h \
	src/google_breakpad/common/mac/macho_utilities.cc \
	src/google_breakpad/common/mac/macho_utilities.h \
	src/google_breakpad/common/mac/macho_walker.cc \
	src/google_breakpad/common/mac/macho_walker.h \
	src/google_breakpad/common/mac/string_utilities.cc \
	src/google_breakpad/common/mac/string_utilities.h \
	src/google_breakpad/common/md5.cc \
	src/google_breakpad/common/md5.h \
	src/google_breakpad/common/scoped_ptr.h \
	src/google_breakpad/common/solaris/dump_symbols.cc \
	src/google_breakpad/common/solaris/dump_symbols.h \
	src/google_breakpad/common/solaris/file_id.cc \
	src/google_breakpad/common/solaris/file_id.h \
	src/google_breakpad/common/solaris/guid_creator.cc \
	src/google_breakpad/common/solaris/guid_creator.h \
	src/google_breakpad/common/solaris/message_output.h \
	src/google_breakpad/common/string_conversion.cc \
	src/google_breakpad/common/string_conversion.h \
	src/google_breakpad/common/windows/guid_string.cc \
	src/google_breakpad/common/windows/guid_string.h \
	src/google_breakpad/common/windows/http_upload.cc \
	src/google_breakpad/common/windows/http_upload.h \
	src/google_breakpad/common/windows/pdb_source_line_writer.cc \
	src/google_breakpad/common/windows/pdb_source_line_writer.h \
	src/google_breakpad/common/windows/string_utils-inl.h \
	src/google_breakpad/common/windows/string_utils.cc \
	src/google_breakpad/processor/testdata/minidump2.dmp \
	src/google_breakpad/processor/testdata/minidump2.dump.out \
	src/google_breakpad/processor/testdata/minidump2.stackwalk.machine_readable.out \
	src/google_breakpad/processor/testdata/minidump2.stackwalk.out \
	src/google_breakpad/processor/testdata/module1.out \
	src/google_breakpad/processor/testdata/module2.out \
	src/google_breakpad/processor/testdata/module3_bad.out \
	src/google_breakpad/processor/testdata/module4_bad.out \
	src/google_breakpad/processor/testdata/symbols/kernel32.pdb/BCE8785C57B44245A669896B6A19B9542/kernel32.sym \
	src/google_breakpad/processor/testdata/symbols/test_app.pdb/5A9832E5287241C1838ED98914E9B7FF1/test_app.sym \
	src/google_breakpad/processor/testdata/test_app.cc \
	src/tools/linux/dump_syms/Makefile \
	src/tools/linux/dump_syms/dump_syms.cc \
	src/tools/linux/symupload/Makefile \
	src/tools/linux/symupload/minidump_upload.cc \
	src/tools/linux/symupload/sym_upload.cc \
	src/tools/mac/crash_report/crash_report.mm \
	src/tools/mac/crash_report/crash_report.xcodeproj/project.pbxproj \
	src/tools/mac/crash_report/on_demand_symbol_supplier.h \
	src/tools/mac/crash_report/on_demand_symbol_supplier.mm \
	src/tools/mac/dump_syms/dump_syms.xcodeproj/project.pbxproj \
	src/tools/mac/dump_syms/dump_syms_tool.cc \
	src/tools/mac/symupload/minidump_upload.m \
	src/tools/mac/symupload/symupload.m \
	src/tools/mac/symupload/symupload.xcodeproj/project.pbxproj \
	src/tools/solaris/dump_syms/Makefile \
	src/tools/solaris/dump_syms/dump_syms.cc \
	src/tools/solaris/dump_syms/run_regtest.sh \
	src/tools/solaris/dump_syms/testdata/dump_syms_regtest.cc \
	src/tools/solaris/dump_syms/testdata/dump_syms_regtest.o \
	src/tools/solaris/dump_syms/testdata/dump_syms_regtest.stabs \
	src/tools/solaris/dump_syms/testdata/dump_syms_regtest.sym \
	src/tools/windows/converter/ms_symbol_server_converter.cc \
	src/tools/windows/converter/ms_symbol_server_converter.h \
	src/tools/windows/converter/ms_symbol_server_converter.vcproj \
	src/tools/windows/dump_syms/dump_syms.cc \
	src/tools/windows/dump_syms/dump_syms.vcproj \
	src/tools/windows/dump_syms/run_regtest.sh \
	src/tools/windows/dump_syms/testdata/dump_syms_regtest.cc \
	src/tools/windows/dump_syms/testdata/dump_syms_regtest.pdb \
	src/tools/windows/dump_syms/testdata/dump_syms_regtest.sym \
	src/tools/windows/symupload/symupload.cc \
	src/tools/windows/symupload/symupload.vcproj

mostlyclean-local:
	-find src -name '*.dwo' -exec rm -f {} +
