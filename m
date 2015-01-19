From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 10/10] drivers: PL011: add support for the ARM SBSA
 generic UART
Date: Mon, 19 Jan 2015 14:56:02 +0100
Message-ID: <45882386.HAzdnpUX2E@wuerfel>
References: <1421428986-11300-1-git-send-email-andre.przywara@arm.com>
 <5407007.ZAjCvvOzus@wuerfel> <54BD0A49.8030107@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <54BD0A49.8030107@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andre Przywara <andre.przywara@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, "rob.herring@linaro.org" <rob.herring@linaro.org>, "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "jslaby@suse.cz" <jslaby@suse.cz>, Dave P Martin <Dave.Martin@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

On Monday 19 January 2015 13:44:41 Andre Przywara wrote:
> 
> > Would we be better off documenting that 8-n-1 is the only allowed settting?
> > I can't think of a reason why anyone would use something else.
> 
> Reading the spec again I see that 8-bit word len is mandated:
> "The generic UART uses 8-bit words, equivalent to UARTLCR_H.WLEN == b11."
> So given this I guess anything other than (8)n1 is pretty useless and
> wouldn't probably be used anyways. This means that we can get rid of the
> optional properties altogether and just add "current-speed" to the list
> of required ones. I am about to implement this.

Ok, great!

	Arnd
