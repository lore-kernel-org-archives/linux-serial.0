From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v6] ACPI / serial: Add peripheral PnP IDs enumeration
 support
Date: Thu, 4 Apr 2013 15:43:43 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88015CC891@SHSMSX101.ccr.corp.intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
 <eb535db4b040bbe8712a975ed70cb3899b5b0fea.1364954385.git.lv.zheng@intel.com>
 <20130403161431.GB21383@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:56904 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760334Ab3DDPnr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 4 Apr 2013 11:43:47 -0400
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

Hi,

> > > +	return snprintf(buf, PAGE_SIZE, "uart\n");
> >
> > What is the "uart" part for?  Isn't that kind of obvious?
> 
> It is the default "peripheral_type" content.
> Before sending next revision out, let me ask a question here:
> Shall I leave this empty as my previous revisions?

Hmm, if this is empty by default then the udev rules may require additional handlings.
Can I use "NONE" here for the user space users?

Thanks and best regards
-Lv

