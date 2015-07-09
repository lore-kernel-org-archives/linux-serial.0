From: Noam Camus <noamc@ezchip.com>
Subject: RE: [PATCH REBASED RESEND] tty/early: make serial8250_early_{in,out}
 static again
Date: Thu, 9 Jul 2015 07:31:52 +0000
Message-ID: <DB4PR02MB2721C87C43495C113613429D6900@DB4PR02MB272.eurprd02.prod.outlook.com>
References: <1435145184-32303-1-git-send-email-vgupta@synopsys.com>
 <1436422838-4512-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436422838-4512-1-git-send-email-vgupta@synopsys.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robh@kernel.org>, Kevin Cernekee <cernekee@gmail.com>
List-Id: linux-serial@vger.kernel.org

> From: Vineet Gupta [mailto:Vineet.Gupta1@synopsys.com] 
> Sent: Thursday, July 09, 2015 9:21 AM
>
> Commit ed71871bed719 ("tty/8250_early: Turn serial_in/serial_out into weak symbols") made these
> routines weak to allow platform specific Big endian override
>
> However recent updates to core, specifically ebc5e20082 ("serial:
> of_serial: Support big-endian register accesses") and 6e63be3fee14
> ("serial: earlycon: Add support for big-endian MMIO accesses") means that round about way to override
> the early serial accessors is no longer needed.

As author of  commit ed71871bed719 my original problem is now solved in more generic way and there is no more need for the __weak attribute on these two early serial accessors.

ACK
