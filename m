From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 1/4] of_serial: add support for setup quirks
Date: Mon, 9 Apr 2012 18:49:20 +0000
Message-ID: <201204091849.20705.arnd@arndb.de>
References: <20120409182041.317.33360.stgit@dwillia2-linux.jf.intel.com> <20120409182203.317.81835.stgit@dwillia2-linux.jf.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:58662 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428Ab2DISt3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 9 Apr 2012 14:49:29 -0400
In-Reply-To: <20120409182203.317.81835.stgit@dwillia2-linux.jf.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: gregkh@linuxfoundation.org, Stephen Warren <swarren@nvidia.com>, linux-kernel@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>, linux-serial@vger.kernel.org, Colin Cross <ccross@android.com>, Olof Johansson <olof@lixom.net>, alan@linux.intel.com

On Monday 09 April 2012, Dan Williams wrote:
> Benign conversion of of_serial.c to offer the option of 'setup' quirks
> similar to how 8250_pci.c houses the pci-serial-device quirks.
> 
> A setup quirk allows custom uart_port ops to specified in the
> of_serial_info data fed to each serial of_device_id.
> 
> Tegra's 'break' quirk is the target consumer.
> 
> Cc: Colin Cross <ccross@android.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Stephen Warren <swarren@nvidia.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/tty/serial/of_serial.c |   68 ++++++++++++++++++++++++++++------------
>  1 files changed, 47 insertions(+), 21 deletions(-)

I don't think this is a good idea. Aside from the bug that you introduce
(you can no longer have multiple ports of the same type because of overwrite
the static info->line number), it seems an unnecessary complication.
Either just add the quirk to the of_serial file based on the compatible value,
or do a trivial new driver that has a subset of the existing one you need,
plus the quirk.

	Arnd 
