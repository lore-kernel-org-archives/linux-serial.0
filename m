From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] amba-pl011: simplify TX handling
Date: Wed, 18 Mar 2015 23:43:48 +0000
Message-ID: <20150318234348.GF8656@n2100.arm.linux.org.uk>
References: <20150317163200.GE3759@e103592.cambridge.arm.com>
 <20150318004255.538fd48e@north>
 <20150318174157.GD3549@e103592.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
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
Cc: Jakub =?utf-8?B?S2ljacWEc2tp?= <moorray3@wp.pl>, Jakub Kicinski <kubakici@wp.pl>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Karol Debogorski <k.debogorski@a2s.pl>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Andre Przywara <Andre.Przywara@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 18, 2015 at 05:41:57PM +0000, Dave P Martin wrote:
>  * uart_wait_until_sent()'s timeout calculations aim to wait for
>    no longer than it takes the FIFO to drain.  However, this function
>    can get called when the serial_core xmit queue for the port is
>    very non-empty -- meaning that the FIFO continues to be topped
>    up for some time.  This can cause more data to be lost.

The code used to wait for the xmit queue to empty (up to closing_wait)
before shutting the port down, which defaulted to 30 seconds.  If the
xmit queue doesn't drain in 30 seconds, it probably never will.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
