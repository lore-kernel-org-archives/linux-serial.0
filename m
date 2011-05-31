From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH v3] 8250_pci: add -ENODEV code for Intel EG20T PCH
Date: Tue, 31 May 2011 10:09:59 +0100
Message-ID: <20110531100959.011ea462@bob.linux.org.uk>
References: <1306808559-4246-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1306808559-4246-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com, toshiharu-linux@dsn.okisemi.com
List-Id: linux-serial@vger.kernel.org

> V2: Delete #ifdef CONFIG_SERIAL_PCH_UART ~ #endif
>     Use quirk table structure

I would keep the ifdef. We want to fall back and if we don't do that
then users currently using 8250 will have their system break on upgrade
which is not acceptable really.

So I'd keep with the patch below but:

> +static int pci_eg20tpch_init(struct pci_dev *dev)
> +{
#if !defined(CONFIG_SERIAL_PCH_UART) && ...
> +	return -ENODEV;
#else
	return 0;
#endif

> +}


I don't think we can avoid that one ifdef without breakage.
