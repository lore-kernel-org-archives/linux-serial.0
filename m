From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: Problem with 4.6-rc2
Date: Tue, 19 Apr 2016 15:21:39 +0900
Message-ID: <20160419062139.GA7574@kroah.com>
References: <57150A3D.6020500@free.fr> <57152224.5080003@hurleysoftware.com>
 <5715279B.9060806@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
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
Cc: Sebastian Frias <sf84@laposte.net>, Mans Rullgard <mans@mansr.com>, Peter Hurley <peter@hurleysoftware.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-serial <linux-serial@vger.kernel.org>, Jean Delvare <jdelvare@suse.de>
List-Id: linux-serial@vger.kernel.org

On Mon, Apr 18, 2016 at 08:29:47PM +0200, Mason wrote:
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
> 
> Peter,
> 
> Thanks for pointing out the problem.
> 
> Greg,
> 
> My ARM-based SoC uses this hardware (Palmchip BK-3103) and it
> now panics on boot.
> 
> Can we revert 8d2acdb9fc3a in time for v4.7?

Now reverted in time for 4.6, sorry about this.

greg k-h
