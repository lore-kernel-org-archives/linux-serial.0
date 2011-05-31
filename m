From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq@rere.qmqm.pl>
Subject: Re: [PATCH v3] 8250_pci: add -ENODEV code for Intel EG20T PCH
Date: Tue, 31 May 2011 10:40:53 +0200
Message-ID: <20110531084052.GA13972@rere.qmqm.pl>
References: <1306808559-4246-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:46664 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752544Ab1EaIkz (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 31 May 2011 04:40:55 -0400
Content-Disposition: inline
In-Reply-To: <1306808559-4246-1-git-send-email-tomoya-linux@dsn.okisemi.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Cc: Alan Cox <alan@linux.intel.com>, gregkh@suse.de, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com, kok.howg.ewe@intel.com, toshiharu-linux@dsn.okisemi.com

On Tue, May 31, 2011 at 11:22:39AM +0900, Tomoya MORINAGA wrote:
> Intel EG20T PCH has UART device which is compatible with 8250.
> Currently, with general configuration, the PCH UART driver is not loa=
ded but
> 8250 standard driver is loaded.
> Therefore, in case of using PCH UART driver, need to disable 8250 pci=
 function.
> However, this procedure is not best solution.
> This patch, in 8250_pci, if the device is the PCH or the family IOH,
> '-ENODEV' is returned.
> As a result, disabling 8250-pci processing becomes unnecessary.
[...]
> +static int pci_eg20tpch_init(struct pci_dev *dev)
> +{
> +	return -ENODEV;
> +}

You could name it just return_ENODEV() or similar and then while lookin=
g
at the device-id table you would know right away what this entry is doi=
ng.

Best Regards,
Micha=B3 Miros=B3aw
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
