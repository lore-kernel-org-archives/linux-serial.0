From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH 0/6] SA11x0 serial updates
Date: Mon, 5 Sep 2016 13:28:10 +0100
Message-ID: <20160905122810.GP1041@n2100.armlinux.org.uk>
References: <20160829100232.GC1041@n2100.armlinux.org.uk>
 <20160829102328.GA28796@n2100.armlinux.org.uk>
 <20160829110157.GE1041@n2100.armlinux.org.uk>
 <20160829112540.GF1041@n2100.armlinux.org.uk>
 <20160829120531.GG1041@n2100.armlinux.org.uk>
 <CACRpkdZFZVq92UAiq+dsHabyEk+_AbQ_B3SOETGru-8Kbp=h9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdZFZVq92UAiq+dsHabyEk+_AbQ_B3SOETGru-8Kbp=h9Q@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jiri Slaby <jslaby@suse.com>
List-Id: linux-serial@vger.kernel.org

On Mon, Sep 05, 2016 at 11:09:38AM +0200, Linus Walleij wrote:
> On Mon, Aug 29, 2016 at 2:05 PM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> 
> > This series converts SA11x0 serial to make use of the mctrl helpers
> > where appropriate.  This allows us to remove several board-specific
> > callbacks.
> 
> >From GPIO and H3600 point of view:
> Acked-by: Linus Walleij <linus.walleij@linaro.org>

Thanks - did you check that the appropriate GPIOs were claimed for
serial in gpio's debugfs?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
