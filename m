From: Jean Delvare <jdelvare@suse.de>
Subject: Re: Problem with 4.6-rc2
Date: Mon, 18 Apr 2016 21:23:03 +0200
Message-ID: <20160418212303.29187018@endymion>
References: <57150A3D.6020500@free.fr> <57152224.5080003@hurleysoftware.com>
 <5715279B.9060806@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5715279B.9060806@free.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mason <slash.tmp@free.fr>
Cc: Sebastian Frias <sf84@laposte.net>, Mans Rullgard <mans@mansr.com>, Peter Hurley <peter@hurleysoftware.com>, Greg KH <gregkh@linuxfoundation.org>, linux-serial <linux-serial@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Peter, Mason,

On Mon, 18 Apr 2016 20:29:47 +0200, Mason wrote:
> On 18/04/2016 20:06, Peter Hurley wrote:
> 
> > On 04/18/2016 09:24 AM, Mason wrote:
> >
> >> I'm running into this panic. I will take a closer look tomorrow.
> >> Any ideas?
> > 
> > commit 8d2acdb9fc3a544ab0442634531834d6007b5467
> > Author: Jean Delvare <jdelvare@suse.de>
> > Date:   Mon Feb 22 09:00:39 2016 +0100
> > 
> >     serial: 8250: Add hardware dependency to RT288X option
> >     
> >     Kconfig option SERIAL_8250_RT288X seems to be only relevant on MIPS
> >     platforms, so do not present it on other architectures, unless
> >     build-testing.
> >     
> >     Signed-off-by: Jean Delvare <jdelvare@suse.de>
> >     Cc: Mans Rullgard <mans@mansr.com>
> >     Cc: Jiri Slaby <jslaby@suse.com>
> >     Acked-by: John Crispin <blogic@openwrt.org>
> >     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > 
> > 
> > Not sure why Greg picked this up over my objections though

Greg applied v1 of my patch. In v2 I added ARCH_TANGO as a possible
dependency, but Greg did pick the update. Mason, is your target machine
an ARCH_TANGO machine, or something else?

> Peter,
> 
> Thanks for pointing out the problem.

Mason, did you check if reverting this commit and re-enabling
SERIAL_8250_RT288X actually solves your problem?

> Greg,
> 
> My ARM-based SoC uses this hardware (Palmchip BK-3103) and it
> now panics on boot.
> 
> Can we revert 8d2acdb9fc3a in time for v4.6?

If not selecting SERIAL_8250_RT288X results in a crash at boot on some
systems, then reverting my commit is not the proper fix. Even after
reverting, you can still omit selecting the option, and get the same
crash. In other words, my commit is not introducing the crash, it must
have been there lurking before.

Whatever code crashes in this case should be made more robust to
properly deal with the situation. Or if it is too much work or too ugly
(not being familiar with the code, I have no idea), then we could
finally go with Peter's earlier proposal of dropping the
SERIAL_8250_RT288X option altogether and unconditionally including the
code in question. In fact I think Peter was supposed to send a patch
doing exactly that.

-- 
Jean Delvare
SUSE L3 Support
