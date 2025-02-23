Received: from fgw21-7.mail.saunalahti.fi (fgw21-7.mail.saunalahti.fi [62.142.5.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593EA18C039
	for <linux-serial@vger.kernel.org>; Sun, 23 Feb 2025 21:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740345024; cv=none; b=g46yF7Th6/Ytlf4wgy7hUiPszRFoCx5n3Ntox2icKsEPgPGdEnOUIhcJniiMTPm3+DW+6chZ4roeRDuhPFVzcJUVDuOUSlpddnIywNawhtwXb4Sbf1/lXqz38g3k5onjGF/h7BOFzY37OZx4ecQ3+Bq2ZSNp45obqf/UtP6+w4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740345024; c=relaxed/simple;
	bh=lImTL5vWnzr5yIsTdR4fXE2f+0q2Fi45JWqnLna7WCE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=muKIqEG1wGwpwrq9uDvzAzZVUBmkeDktWv65xhuAAUipa3dnj2a/KyOpkwbqy6k6+ACyTWY2VYigfH1qUv+hmlA7FubGaWA3pQT/oLOfSnbV1lAQJk4TpkDT7M4snbjCyBs7D5Q2DUpGBp0SK1Gwt6pz184QpuQJZ+fkFhPL9HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 90c04476-f22a-11ef-a29e-005056bdfda7;
	Sun, 23 Feb 2025 23:10:10 +0200 (EET)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 23 Feb 2025 23:10:10 +0200
To: adamsimonelli@gmail.com, Petr Mladek <pmladek@suse.com>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 0/2] Optionally allow ttynull to be selected as a
 default console
Message-ID: <Z7uOsqky4Tw9J6QR@surfacebook.localdomain>
References: <20250223204456.1913392-1-adamsimonelli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-serial@vger.kernel.org
List-Id: <linux-serial.vger.kernel.org>
List-Subscribe: <mailto:linux-serial+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-serial+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250223204456.1913392-1-adamsimonelli@gmail.com>

Sun, Feb 23, 2025 at 03:44:54PM -0500, adamsimonelli@gmail.com kirjoitti:
> From: Adam Simonelli <adamsimonelli@gmail.com>
> 
> When switching to a CONFIG_VT=n world, at least on x86 systems,
> /dev/console becomes /dev/ttyS0. This can cause some undesired effects.
> /dev/console's behavior is now tied to the physical /dev/ttyS0, which when
> disconnected can cause isatty() to fail when /dev/ttyS0 is disconnected,
> and users who upgrade to a theoretical vt-less kernel from their
> distribution who have a device such as a science instrument connected to
> their /dev/ttyS0 port will suddenly see it receive kernel log messages.
> 
> When the new CONFIG_NULL_TTY_CONSOLE option is turned on, this will allow
> the ttynull device to be leveraged as the default console. Distributions
> that had CONFIG_VT turned on before will be able to leverage this option
> to where /dev/console is still backed by a psuedo device, avoiding these
> issues, without needing to enable the entire VT subsystem.

This rings a bell of the following

https://lore.kernel.org/all/20201111135450.11214-1-pmladek@suse.com/
https://lore.kernel.org/all/20210107164400.17904-1-pmladek@suse.com/
https://lore.kernel.org/all/20210108114847.23469-1-pmladek@suse.com/

I don't see any mention in the commit message about these, have you studied the
cases? Will your change anyhow affect the described there?

-- 
With Best Regards,
Andy Shevchenko


