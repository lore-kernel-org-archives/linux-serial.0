From: Jakub =?UTF-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>
Subject: Re: [PATCH] amba-pl011: simplify TX handling
Date: Wed, 18 Mar 2015 21:26:09 +0100
Message-ID: <20150318212609.4d4f61a6@north>
References: <20150317163200.GE3759@e103592.cambridge.arm.com>
 <20150318004255.538fd48e@north>
 <20150318174157.GD3549@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150318174157.GD3549@e103592.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave P Martin <Dave.Martin@arm.com>
Cc: Russell King <linux@arm.linux.org.uk>, Jakub Kicinski <kubakici@wp.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Karol Debogorski <k.debogorski@a2s.pl>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Andre Przywara <Andre.Przywara@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wed, 18 Mar 2015 17:41:57 +0000, Dave P Martin wrote:
> > This is exactly what I did:
> > # stty -F /dev/ttyAMA0 115200 -onlcr
> > # cat 1MB_text_file > /dev/ttyAMA0
> > ^C
> > Now AMA0 is dead.  If I waited until the whole file was written,
> > everything was fine.  This was 100% reproducible and I later checked
> > that on .shutdown() the FIFO was full (no IRQ pending yet).  Initially I
> > tried to play around with CR programming on .shutdown() but it didn't
> > change anything (according to Broadcom docs one should be very careful
> > not to touch CR while UART is busy).
> 
> Interesting... I missed this because the systemd issue that got me
> started on this only shows up of the console is on the PL011.  Once
> a shell is running on ttyAMA0, the port is always open, so the effects
> of shutting down and restarting the pl011 are not seen.
> 
> I'm actually suspicious of the correct behaviour here.  serial_core
> waits for the UART to drain via uart_wait_until_sent(), but there are
> some oddities:
> 
>  * The wait is abandoned early if there is a pending signal.  This
>    means that some output already sent to the kernel via write() is
>    is simply lost.  This feels a bit odd -- for all other I/O I can
>    think of, write() does not guarantee that the data has reached
>    its destination, but on return it usually does guarantee that the
>    data _will_ reach its destination (except for unrecoverable I/O
>    errors).
> 
>    This behaviour does mean that pl011_shutdown() is invoked with
>    a non-empty FIFO if the only process with the port open is killed
>    by a signal while output is pending, causing the hangup.
> 
>  * uart_wait_until_sent()'s timeout calculations aim to wait for
>    no longer than it takes the FIFO to drain.  However, this function
>    can get called when the serial_core xmit queue for the port is
>    very non-empty -- meaning that the FIFO continues to be topped
>    up for some time.  This can cause more data to be lost.

I confess that the way serial_core works is not very intuitive for me
either, I can only add to your list.  For instance I observed
that .start_tx() called eight times during the initial load.  Why?
Obviously the first one fills up the FIFO and the subsequent just waste
CPU time.  I remember looking at the serial_core and it seemed like the
repeated calls must be coming from the higher layers... Admittedly I was
too lazy to just add a dump_stack() and see for myself ;)
