From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] serial: pl010 is no longer broken
Date: Wed, 25 Feb 2015 17:04:15 +0100
Message-ID: <12501115.8EHeHJoUSj@wuerfel>
References: <3118156.gAoOHDhYSV@wuerfel> <20150225160216.GB29781@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20150225160216.GB29781@kroah.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Wednesday 25 February 2015 08:02:16 Greg Kroah-Hartman wrote:
> On Wed, Feb 25, 2015 at 04:06:09PM +0100, Arnd Bergmann wrote:
> > As more ARM platforms are moving into ARCH_MULTIPLATFORM, we can now
> > have integrator and versatile in the same kernel, and first one selects
> > this driver, causing a Kconfig warning:
> > 
> > warning: (ARCH_INTEGRATOR_AP) selects SERIAL_AMBA_PL010 which has unmet direct dependencies (TTY && HAS_IOMEM && ARM_AMBA && (BROKEN || !ARCH_VERSATILE))
> > 
> > It turns out that it has not been broken on versatile for a long time,
> > so we can remove the statement here.

> Is it ok if we wait for 4.1-rc1 for this, or do you think it's really ok
> for 4.0-final?

It's not urgent and should just go into 4.1.

	Arnd
