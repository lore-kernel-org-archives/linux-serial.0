From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: Does braille console work?
Date: Thu, 16 Mar 2017 17:02:53 +0300
Message-ID: <1bb67bee-b8f9-2835-725a-f36fda085216@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, Joe Perches <joe@perches.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi,

I am looking at the braille console code and don't understand how its
initialization works.

This is from kernel/printk/braille.c:

char *_braille_console_setup(char **str, char **brl_options)
{
	if (!strncmp(*str, "brl,", 4)) {
		*brl_options = "";
		*str += 4;                                     (3)
	} else if (!strncmp(*str, "brl=", 4)) {
		*brl_options = *str + 4;
		*str = strchr(*brl_options, ',');
		if (!*str)
			pr_err("need port name after brl=\n"); (2)
		else
			*((*str)++) = 0;                       (3)
	} else
		return NULL;                                   (1)

	return *str;
}

There can be 3 outcomes from this function:
1) it returns NULL and does not set brl_options
2) it returns NULL and set the variable pointed by str to NULL
3) it returns non-NULL

And this is how it is called in a __setup() function from kernel/printk/printk.c:

static int __init console_setup(char *str)
{
	char buf[sizeof(console_cmdline[0].name) + 4]; /* 4 for "ttyS" */
	char *s, *options, *brl_options = NULL;
	int idx;

	if (_braille_console_setup(&str, &brl_options))
		return 1;

	/*
	 * Decode str into name, index, options.
	 */
	if (str[0] >= '0' && str[0] <= '9') {
		strcpy(buf, "ttyS");
		strncpy(buf + 4, str, sizeof(buf) - 5);
	} else {
		strncpy(buf, str, sizeof(buf) - 1);
	}

	[... Parse other console options here ...]


	__add_preferred_console(buf, idx, options, brl_options);
	console_set_on_cmdline = 1;
	return 1;
}
__setup("console=", console_setup);

To register a braille console (i. e. to call __add_preferred_console()
with non-NULL brl_options) function _braille_console_setup() should
return NULL and initialize brl_options. 

1) in this case brl_options is NULL and non-braille console is registered
2) kernel produces oops later in console_setup().  I reproduced it
   passing "console=brl=aaa" parameter to kernel, see below.
3) no console is registered

So braille console registration should not work.  What do I miss?

The code was changed in July/August 2013 in commits

commit bbeddf52adc1 ("printk: move braille console support into separate braille.[ch] files")
commit 2cfe6c4ac7ee ("printk: Fix return of braille_register_console()")

So it looks like braille console has not been used for more than 3 years.
Should we remote it?

------------------------------------------------------------

Kernel command line: systemd.show_status=no rootwait rw root=/dev/sda7 acpi=force earlycon console=brl=aaa
braille: need port name after brl=
Unable to handle kernel NULL pointer dereference at virtual address 00000000
pgd = fffffc00089b0000
[00000000] *pgd=0000001ffffe0003, *pud=0000001ffffe0003, *pmd=0000001ffffe0003, *pte=0000000000000000
Internal error: Oops: 96000006 [#1] PREEMPT SMP
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 4.11.0-rc2-07-00033-g417d6c6d1a16-dirty #727
Hardware name: Cavium ThunderX CN88XX board (DT)
task: fffffc0008868000 task.stack: fffffc0008840000
PC is at console_setup+0x28/0x108
LR is at console_setup+0x20/0x108
pc : [<fffffc00087cd71c>] lr : [<fffffc00087cd714>] pstate: 800000c5
sp : fffffc0008843e70
x29: fffffc0008843e70 x28: 0000000000000000 
x27: fffffc00087a7b18 x26: 0000000000000001 
x25: fffffc000880ccb9 x24: 0000000000000008 
x23: fffffc0008812b40 x22: 0000000000000000 
x21: fffffe1ffffafece x20: fffffe1ffffafec6 
x19: 0000000000000000 x18: 0000000000000001 
x17: 0000000000000000 x16: 0000000000000018 
x15: 0000000000020000 x14: 00000000fffffff0 
x13: fffffc0008873158 x12: fffffc00088fc82a 
x11: 0000000000000000 x10: 000000000000002d 
x9 : 0000000000000023 x8 : 7262207265746661 
x7 : 20656d616e207472 x6 : 000000000000002e 
x5 : 0000000000000400 x4 : 0000000000000000 
x3 : 0000000000000002 x2 : 0000000000000002 
x1 : 0000000000000001 x0 : 0000000000000000 

Process swapper (pid: 0, stack limit = 0xfffffc0008840000)
Stack: (0xfffffc0008843e70 to 0xfffffc0008844000)
3e60:                                   fffffc0008843ec0 fffffc00087c0600
3e80: fffffc0008812330 fffffe1ffffafec6 fffffc0008812060 0000000000000000
3ea0: fffffe1ffffafed2 fffffc00087c0598 fffffc0008811f40 fffffe1ffffafec6
3ec0: fffffc0008843f10 fffffc00080c816c fffffc0008623558 fffffe1ffffafec6
3ee0: fffffc00087a7b18 fffffe1ffffafece 0000000000000080 fffffc0008707130
3f00: 00000000000000bc fffffe1ffffafed5 fffffc0008843fa0 fffffc00087c094c
3f20: fffffc00087f3948 fffffc00088d0000 fffffc0008863000 fffffc00088d0000
3f40: fffffe1ffffafe80 fffffc00087f3948 0000000000000174 0000001fffaf51a0
3f60: 0000001fffa38d00 0000000001bc0018 fffffc000886e6f0 fffffc000870e560
3f80: ffffffffffffffff fffffc00087c0558 0000000000000000 fffffc00087a5db8
3fa0: fffffc0008843ff0 fffffc00087c01e8 0000001ffa3d0a18 0000000021200000
3fc0: 0000000021200000 000000074fb10f48 0000000000000000 0000000000000000
3fe0: 0000000000000000 fffffc00087f3948 0000000000000000 000000000192c27c
Call trace:
Exception stack(0xfffffc0008843ca0 to 0xfffffc0008843dd0)
3ca0: 0000000000000000 0000040000000000 fffffc0008843e70 fffffc00087cd71c
3cc0: fffffc0008843e00 00000000ffffffc8 fffffc0008843d00 fffffc00080f6a80
3ce0: fffffc0008843e40 fffffc0008843e40 fffffc0008843e00 00000000ffffffc8
3d00: fffffc0008843db0 fffffc000813a418 fffffc0008843e98 fffffe1ffffafece
3d20: fffffc0008843ea0 0000000000000000 fffffc0008812b40 0000000000000008
3d40: 0000000000000000 0000000000000001 0000000000000002 0000000000000002
3d60: 0000000000000000 0000000000000400 000000000000002e 20656d616e207472
3d80: 7262207265746661 0000000000000023 000000000000002d 0000000000000000
3da0: fffffc00088fc82a fffffc0008873158 00000000fffffff0 0000000000020000
3dc0: 0000000000000018 0000000000000000
[<fffffc00087cd71c>] console_setup+0x28/0x108
[<fffffc00087c0600>] unknown_bootoption+0xa8/0x1d0
[<fffffc00080c816c>] parse_args+0x2a4/0x4a8
[<fffffc00087c094c>] start_kernel+0x180/0x378
[<fffffc00087c01e8>] __primary_switched+0x64/0x6c
Code: f81e0c3f 97e4a534 b50006c0 f94017b3 (39400260) 
---[ end trace 0000000000000000 ]---
Kernel panic - not syncing: Attempted to kill the idle task!
---[ end Kernel panic - not syncing: Attempted to kill the idle task!

-- 
All the best
Alekséy Makárov
