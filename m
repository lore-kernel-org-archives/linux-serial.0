From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH REBASED RESEND] tty/early: make serial8250_early_{in,out}
 static again
Date: Fri, 10 Jul 2015 13:42:32 -0400
Message-ID: <55A00408.5010603@hurleysoftware.com>
References: <1435145184-32303-1-git-send-email-vgupta@synopsys.com> <1436422838-4512-1-git-send-email-vgupta@synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436422838-4512-1-git-send-email-vgupta@synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>, linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>, Kevin Cernekee <cernekee@gmail.com>, Noam Camus <noamc@ezchip.com>
List-Id: linux-serial@vger.kernel.org

On 07/09/2015 02:20 AM, Vineet Gupta wrote:
> Commit ed71871bed719 ("tty/8250_early: Turn serial_in/serial_out into
> weak symbols") made these routines weak to allow platform specific
> Big endian override
> 
> However recent updates to core, specifically ebc5e20082 ("serial:
> of_serial: Support big-endian register accesses") and 6e63be3fee14
> ("serial: earlycon: Add support for big-endian MMIO accesses") means
> that round about way to overide the early serial accessors is no longer
> needed.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
