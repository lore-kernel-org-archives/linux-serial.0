From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: Linux 4.4-rc1
Date: Sun, 15 Nov 2015 21:27:56 -0800
Message-ID: <20151116052756.GA1546@roeck-us.net>
References: <CA+55aFz8NHGxf0cvgQOVAmB=i+g+egty_j6nMYc1YBv4tXAvxg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFz8NHGxf0cvgQOVAmB=i+g+egty_j6nMYc1YBv4tXAvxg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mikael Starvik <starvik@axis.com>, Jesper Nilsson <jesper.nilsson@axis.com>, linux-cris-kernel@axis.com, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Sun, Nov 15, 2015 at 05:24:37PM -0800, Linus Torvalds wrote:
> So it's Sunday, two weeks has passed, and so 4.4-rc1 is out there and
> the merge window is closed.
> 
> As usual, the full shortlog is much too big to post, so appended is
> the usual shortlog of just my merges, which just shows who I did pulls
> from, with a very short comment on each merge.
> 
> Just looking at the patch itself, things look fairly normal at a high
> level, possibly a bit more driver-heavy than usual with about 75% of
> the patch being drivers, and 10% being architecture updates. The
> remaining 15% is documentation, filesystem, core networking (as
> opposed to network drivers), tooling and some core infrastructure.
> 
> The driver changes are all over, although staging, networking and GPU
> drivers stand out (and those three areas account for over half of the
> driver changes - roughly 40% of the whole patch).
> 
> On the architecture side, ARM (when counting both 32-bit and 64-bit)
> accounts for about half the changes, with x86, powerpc, mips, chris
> and s390 accounting for the other half.
> 
> Go out and test.
> 
Build results:
	total: 144 pass: 143 fail: 1
Failed builds:
	cris:allnoconfig

Qemu test results:
	total: 95 pass: 94 fail: 1
Failed tests:
	cris:crisv32_defconfig

cris:allnoconfig fails to build because of section mismatches, which is now
fatal with allnoconfig builds (since 47490ec141b9, "modpost: Add flag -E for
making section mismatches fatal"). Proposed patches to fix the problems are
available at [1] and [2]. Other allnoconfig builds (untested by me) probably
fail as well, though.

The cris:crisv32_defconfig qemu test crashes because of interference between
commit 7d8c70d8048c ("serial: mctrl-gpio: rename init function") and commit
7b9c5162c182 ("serial: etraxfs-uart: use mctrl_gpio helpers for handling
modem signals"). A proposed patch is available at [3].

Further details are available at http://server.roeck-us.net:8010/builders.

Guenter

---
[1] https://patchwork.kernel.org/patch/7592471/
[2] https://patchwork.kernel.org/patch/7592461/
[3] https://patchwork.kernel.org/patch/7533041/
