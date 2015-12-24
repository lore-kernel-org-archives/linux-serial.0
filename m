From: Guenter Roeck <linux@roeck-us.net>
Subject: Problems with 'serial: 8250: move of_serial code to 8250 directory'
 in linux-next
Date: Wed, 23 Dec 2015 17:57:14 -0800
Message-ID: <567B50FA.4050603@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "arnd@arndb.de" <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi Arnd,

I get a number of runtime failures in -next since commit afd7f88f1577
("serial: 8250: move of_serial code to 8250 directory"). Looking into the commit,
it turns out that you added

	obj-$(CONFIG_SERIAL_8250_OF)           += 8250_of.o

to drivers/tty/serial/8250/Makefile, but there is no SERIAL_8250_OF Kconfig option.
As a result, the file is never compiled. I replaced the above with

	obj-$(CONFIG_SERIAL_OF_PLATFORM)       += 8250_of.o

but that doesn't help, since the file does not compile. I fixed the first error
(linux/nwpserial.h no longer exists), but then the build complains that 8250/8250.h
doesn't exist either. With that, I gave up.

Can you please have a look ? I bisected the problem with xtensa:generic_kc705_defconfig.
I suspect that other failures (eg with openrisc and possibly some of the arm failures)
may have the same root cause.

Thanks,
Guenter

---
bisect log:

# bad: [80c75a0f1d81922bf322c0634d1e1a15825a89e6] Add linux-next specific files for 20151223
# good: [4ef7675344d687a0ef5b0d7c0cee12da005870c0] Linux 4.4-rc6
git bisect start 'HEAD' 'v4.4-rc6'
# good: [52c8be920db8e42d195ca7fe93fe31aa9958100e] Merge remote-tracking branch 'drm/drm-next'
git bisect good 52c8be920db8e42d195ca7fe93fe31aa9958100e
# bad: [d8f8df3c2db6d4d663b5c11f26c6a7df35b35d8c] Merge remote-tracking branch 'tty/tty-next'
git bisect bad d8f8df3c2db6d4d663b5c11f26c6a7df35b35d8c
# good: [29b2e6fc6bbeaddc2dcf4b0afd9c1fac2345eab5] Merge remote-tracking branch 'dt-rh/for-next'
git bisect good 29b2e6fc6bbeaddc2dcf4b0afd9c1fac2345eab5
# good: [8cd6990bf71d89c106e64da0af35d3f4b007c6ec] Merge branch 'x86/platform'
git bisect good 8cd6990bf71d89c106e64da0af35d3f4b007c6ec
# good: [cf3a06027aa2f2f11437d14a523566cae39089eb] Merge remote-tracking branch 'kvm-arm/next'
git bisect good cf3a06027aa2f2f11437d14a523566cae39089eb
# good: [8b775393fab4eb9c248532e19655409674a7fdbd] Merge remote-tracking branch 'leds/for-next'
git bisect good 8b775393fab4eb9c248532e19655409674a7fdbd
# good: [89222e62662237faee90cd8486d23350f26b181d] tty: core: Prefer pr_* to printk(*)
git bisect good 89222e62662237faee90cd8486d23350f26b181d
# bad: [7ec758718920e5e5876d0d02ece6855128c8eb1e] tty: amba-pl011: add support for ZTE UART (EXPERIMENTAL)
git bisect bad 7ec758718920e5e5876d0d02ece6855128c8eb1e
# good: [3ac4ae4736d404c436edf3b2ecfd941368f9e247] serial:bfin-uart:Remove 'struct timeval'
git bisect good 3ac4ae4736d404c436edf3b2ecfd941368f9e247
# bad: [b985e9e368f0db4fee940ad86197f413779d4b63] n_tty: Reduce branching in canon_copy_from_read_buf()
git bisect bad b985e9e368f0db4fee940ad86197f413779d4b63
# bad: [afd7f88f157796e586fc99d62da13a54024e0731] serial: 8250: move of_serial code to 8250 directory
git bisect bad afd7f88f157796e586fc99d62da13a54024e0731
# good: [4e33870b3bb691996354a8f9e8f69458b4fc34d9] serial: of: CONFIG_SERIAL_8250 is always set
git bisect good 4e33870b3bb691996354a8f9e8f69458b4fc34d9
# first bad commit: [afd7f88f157796e586fc99d62da13a54024e0731] serial: 8250: move of_serial code to 8250 directory
