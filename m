From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v6] linux,stdout-path helper
Date: Mon, 12 Aug 2013 08:04:44 +0200
Message-ID: <20130812060444.GI26614@pengutronix.de>
References: <1375706445-15375-1-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1375706445-15375-1-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
Cc: devicetree@vger.kernel.org, kernel@pengutronix.de, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, rob.herring@calxeda.com, linux-serial@vger.kernel.org, grant.likely@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Greg,

Given that we have Robs Ack, can you take this series?

Sascha

On Mon, Aug 05, 2013 at 02:40:43PM +0200, Sascha Hauer wrote:
> The following adds a helper for matching the linux,stdout-path property
> in the chosen node and makes use of it in the i.MX serial
> 
> This is a series originally created by me. It was hijacked and then abandoned
> by Jean-Christophe for v5. I reverted the changes by Jean-Christophe since
> they introduced changes to the devicetree binding. Instead I'd like to have
> the existing binding implemented first before changing it.
> 
> Sascha
> 
> changes since v5:
> - reverted changes from v4
> - parse linux,stdoutpath property in of_alias_scan as suggested by Grant
> changes since v4:
> - add option support and check stdout-path too
> changes since v3:
> - move code from separate files to drivers/of/base.c and include/linux/of.h
> changes since v2:
> - move helper to OF core and make it independent of serial devices
> changes since v1:
> - move it out of the i.MX serial driver and make it generic for serial devices.
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
