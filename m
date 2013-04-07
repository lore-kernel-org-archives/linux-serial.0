From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v6] ACPI / serial: Add peripheral PnP IDs enumeration
 support
Date: Sun, 7 Apr 2013 03:11:51 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88015CDA38@SHSMSX101.ccr.corp.intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
 <eb535db4b040bbe8712a975ed70cb3899b5b0fea.1364954385.git.lv.zheng@intel.com>
 <20130403161431.GB21383@kroah.com>
 <1AE640813FDE7649BE1B193DEA596E88015CC891@SHSMSX101.ccr.corp.intel.com>
 <20130404182335.GC24711@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20130404182335.GC24711@kroah.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>
List-Id: linux-serial@vger.kernel.org

> > Hi,
> >
> > > > > +	return snprintf(buf, PAGE_SIZE, "uart\n");
> > > >
> > > > What is the "uart" part for?  Isn't that kind of obvious?
> > >
> > > It is the default "peripheral_type" content.
> > > Before sending next revision out, let me ask a question here:
> > > Shall I leave this empty as my previous revisions?
> >
> > Hmm, if this is empty by default then the udev rules may require additional
> handlings.
> > Can I use "NONE" here for the user space users?
> 
> No, just don't create the sysfs file at all for that type of device.

Sorry for the delayed reply.

I was thinking developers are encouraged to use the default attributes.
In the tty subsystem, the default attributes are owned by the tty drivers, thus I added peripheral_type file in the serial layer.

If we want to have it as a dynamic attribute, we may modify the codes in the tty_register_device_attr, splitting device_register into two parts, and add sysfs addition codes between the device_initialize and device_add.
So that the uevents received by the user space can have this attribute set.
Sorry that I need your confirmation before doing such modification.

Thanks and best regards
-Lv
