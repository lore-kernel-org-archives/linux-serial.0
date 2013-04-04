From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6] ACPI / serial: Add peripheral PnP IDs enumeration
 support
Date: Thu, 4 Apr 2013 11:23:35 -0700
Message-ID: <20130404182335.GC24711@kroah.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
 <eb535db4b040bbe8712a975ed70cb3899b5b0fea.1364954385.git.lv.zheng@intel.com>
 <20130403161431.GB21383@kroah.com>
 <1AE640813FDE7649BE1B193DEA596E88015CC891@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:57449 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764374Ab3DDSXj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Apr 2013 14:23:39 -0400
Received: by mail-pb0-f42.google.com with SMTP id up7so1577516pbc.1
        for <linux-serial@vger.kernel.org>; Thu, 04 Apr 2013 11:23:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88015CC891@SHSMSX101.ccr.corp.intel.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

On Thu, Apr 04, 2013 at 03:43:43PM +0000, Zheng, Lv wrote:
> Hi,
> 
> > > > +	return snprintf(buf, PAGE_SIZE, "uart\n");
> > >
> > > What is the "uart" part for?  Isn't that kind of obvious?
> > 
> > It is the default "peripheral_type" content.
> > Before sending next revision out, let me ask a question here:
> > Shall I leave this empty as my previous revisions?
> 
> Hmm, if this is empty by default then the udev rules may require additional handlings.
> Can I use "NONE" here for the user space users?

No, just don't create the sysfs file at all for that type of device.

greg k-h
