From: "Zheng, Lv" <lv.zheng@intel.com>
Subject: RE: [PATCH v6] ACPI / serial: Add peripheral PnP IDs enumeration
 support
Date: Sun, 7 Apr 2013 03:05:43 +0000
Message-ID: <1AE640813FDE7649BE1B193DEA596E88015CDA22@SHSMSX101.ccr.corp.intel.com>
References: <cover.1354505471.git.lv.zheng@intel.com>
 <eb535db4b040bbe8712a975ed70cb3899b5b0fea.1364954385.git.lv.zheng@intel.com>
 <20130403161431.GB21383@kroah.com>
 <1AE640813FDE7649BE1B193DEA596E88015CC828@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:37516 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161315Ab3DGDG0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 6 Apr 2013 23:06:26 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E88015CC828@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

Hi, Greg

I think I may misunderstand what you mean here, let me confirm again.
Sorry for doing this.

> > > +#ifdef CONFIG_ACPI_UART
> > > +int acpi_uart_get_peripheral_type(struct device *dev,
> > > +	char *buf, size_t size);
> > > +#else
> > > +static inline int acpi_uart_get_peripheral_type(struct device *dev,
> > > +	char *buf, size_t size)
> > > +{
> > > +	return -ENODEV;
> > > +}
> > > +#endif

> > I see you never tested this code without the configuration option enabled :(

I was thinking you were talking about test plans.
Since I didn't see any issues here and I just didn't want to argue on this topic and replied in this way. :-)
The only user - uart_get_attr_peripheral_type with "int" return value check can ensure no issues here.
> > > +static ssize_t uart_get_attr_peripheral_type(struct device *dev,
> > > +		struct device_attribute *attr, char *buf) {
> > > +	int len;
> > > +
> > > +	len = acpi_uart_get_peripheral_type(dev, buf, 1024);
> > > +	if (len > 0) {
> > > +		buf[len++] = '\n';
> > > +		return len;
> > > +	}
> > > +	return snprintf(buf, PAGE_SIZE, "uart\n");

Now I realize that you might be talking about the "-NODEV" return value is not a good choice, "0" or something else is better.
Shall I return 0 here?

Thanks and best regards
-Lv

