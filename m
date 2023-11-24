Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="SoZ0keqs"
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37552D6F;
	Thu, 23 Nov 2023 21:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:Mime-Version:Message-Id:Cc:To:From
	:Date:subject:date:message-id:reply-to;
	bh=OGd+AG6nBWS2xFVnRaE8Ij0SVFyEY+i0EZHwc9tVSsQ=; b=SoZ0keqsb6yBkNjbMb/OUosU7H
	ZruO9W5Jb5sEHt7OYpa1WV+BYjB/dFmn67S5WAyx3gX+TSlm2lATN5KZyKhRxhwLBafYe6qasunhH
	X/DLuYUcJKOaet3AR5Xv3lXLG+Y/0u6Dclr0mzT72MSJPm0jXY7jeQECSyqPZOZu+C64=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:48020 helo=pettiford)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1r6ONj-0005Om-ET; Fri, 24 Nov 2023 00:05:36 -0500
Date: Fri, 24 Nov 2023 00:05:34 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, lech.perczak@camlingroup.com, Hugo Villeneuve
 <hvilleneuve@dimonoff.com>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org
Message-Id: <20231124000534.aa8f0c866753c3a9e6844354@hugovil.com>
In-Reply-To: <ZV_GHRhqCdeCHV_a@smile.fi.intel.com>
References: <20231030211447.974779-1-hugo@hugovil.com>
	<ZV_GHRhqCdeCHV_a@smile.fi.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
Subject: Re: [PATCH] serial: sc16is7xx: improve regmap debugfs by using one
 regmap per port
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

On Thu, 23 Nov 2023 23:37:33 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, Oct 30, 2023 at 05:14:47PM -0400, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > With this current driver regmap implementation, it is hard to make sense
> > of the register addresses displayed using the regmap debugfs interface,
> > because they do not correspond to the actual register addresses documented
> > in the datasheet. For example, register 1 is displayed as registers 04 thru
> > 07:
> > 
> > $ cat /sys/kernel/debug/regmap/spi0.0/registers
> >   04: 10 -> Port 0, register offset 1
> >   05: 10 -> Port 1, register offset 1
> >   06: 00 -> Port 2, register offset 1 -> invalid
> >   07: 00 -> port 3, register offset 1 -> invalid
> >   ...
> > 
> > The reason is that bits 0 and 1 of the register address correspond to the
> > channel (port) bits, so the register address itself starts at bit 2, and we
> > must 'mentally' shift each register address by 2 bits to get its real
> > address/offset.
> > 
> > Also, only channels 0 and 1 are supported by the chip, so channel mask
> > combinations of 10b and 11b are invalid, and the display of these
> > registers is useless.
> > 
> > This patch adds a separate regmap configuration for each port, similar to
> > what is done in the max310x driver, so that register addresses displayed
> > match the register addresses in the chip datasheet. Also, each port now has
> > its own debugfs entry.
> > 
> > Example with new regmap implementation:
> > 
> > $ cat /sys/kernel/debug/regmap/spi0.0-port0/registers
> > 1: 10
> > 2: 01
> > 3: 00
> > ...
> > 
> > $ cat /sys/kernel/debug/regmap/spi0.0-port1/registers
> > 1: 10
> > 2: 01
> > 3: 00
> > 
> > As an added bonus, this also simplifies some operations (read/write/modify)
> > because it is no longer necessary to manually shift register addresses.
> 
> This change might be problematic, i.e. ...
> 
> ...
> 
> >  		regmap_update_bits(
> >  			s->regmap,
> > -			SC16IS7XX_IOCONTROL_REG << SC16IS7XX_REG_SHIFT,
> > +			SC16IS7XX_IOCONTROL_REG,
> >  			SC16IS7XX_IOCONTROL_MODEM_A_BIT |
> >  			SC16IS7XX_IOCONTROL_MODEM_B_BIT, s->mctrl_mask);
> 
> ...if this happens inside another regmap operation it might collide with this
> as there is no more shared locking (and if driver is going to be converted to
> use an external lock, the one in regmap might be disabled). But I haven't
> checked anyhow deeply this, so just a heads up for the potential issue.

Hi Andy,
are you refering to the above piece of code as the only location where
this could be problematic?

If yes, then it is located inside sc16is7xx_setup_mctrl_ports(), which
is called only during sc16is7xx_probe(), and I assume it should be ok.

> 
> ...
> 
> > -	ret = regmap_read(regmap,
> > -			  SC16IS7XX_LSR_REG << SC16IS7XX_REG_SHIFT, &val);
> > +	ret = regmap_read(regmaps[0], SC16IS7XX_LSR_REG, &val);
> 
> Here is a probe, most likely no issues.

Ok.

> 
> >  	if (ret < 0)
> >  		return -EPROBE_DEFER;
> 
> ...
> 
> > +static const char *sc16is7xx_regmap_name(unsigned int port_id)
> > +{
> > +	static char buf[6];
> > +
> > +	snprintf(buf, sizeof(buf), "port%d", port_id);
> 
> Should be %u.

Yes. I just noticed that Greg has applied the patch to its tty-testing
branch, I assume I should just send a new patch to fix it?

Thank you for the review,
Hugo.

 
> > +	return buf;
> > +}
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 
