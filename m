From: "Kaz Kylheku" <kaz@zeugmasystems.com>
Subject: RE: Rename Sibyte duart devices?
Date: Mon, 3 Dec 2007 13:41:09 -0800
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C552E883@exchange.ZeugmaSystems.local>
References: <20071203130818.GA6466@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mips-bounce@linux-mips.org>
Content-class: urn:content-classes:message
In-Reply-To: <20071203130818.GA6466@linux-mips.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Ralf Baechle wrote:
> Devices created by udev have been named duart? instead of the common
> ttyS?.  This is a nuisance because it requires changes to all sorts of
> config files such as /etc/inittab, /etc/securetty etc. to work.
> suggest to kill the problem by the root by something like the below
> patch.  Comments? 

I can see this kind of a change being somewhat sneaky; some Linux users
on SiByte systems have already worked around for the duart naming not by
patching the kernel but by modifying their text configurations to use
the duart naming. After they figure out why, after upgrading to a new
kernel, their system doesn't work any more, they will still have the
problem that the newer and older kernel require different text
configuration in the file system with respect to the tty devices. It's
nice to be able to pull out an older kernel and boot with it, without
having to remember a list of things to tweak.

To be forward and backward compatible, the kernel should perhaps offer
the device under both aliases: /etc/TTYSx and /etc/duartx.

Kaz "Kompatibility Kurmudgeon" Kylheku
