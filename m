From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH] serial: SERIAL_MRST_MAX3110 should depend on X86_MRST
Date: Tue, 27 Sep 2011 14:10:16 +0200
Message-ID: <201109271410.16584.jdelvare@suse.de>
References: <201109162240.16874.jdelvare@suse.de> <20110927120115.376b3c31@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:48380 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753539Ab1I0MKS (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Tue, 27 Sep 2011 08:10:18 -0400
In-Reply-To: <20110927120115.376b3c31@bob.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-serial@vger.kernel.org

On Tuesday 27 September 2011 01:01:15 pm Alan Cox wrote:
> On Fri, 16 Sep 2011 22:40:16 +0200
> 
> Jean Delvare <jdelvare@suse.de> wrote:
> > As I understand it, driver mrst_max3110 is only useful on
> > Moorestown systems, so it should depend on X86_MRST.
> 
> Digging into this it builds fine on any X86 so it's more useful that
>  it is able to get build tested than to add extra config stuff making
>  it hard to catch bugs when changing the serial layer.

OK, fair enough.

-- 
Jean Delvare
Suse L3
