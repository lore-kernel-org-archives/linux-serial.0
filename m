From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v2] serial/8250_dw: use platform_get_irq() instead of
 platform_get_resource()
Date: Tue, 3 Mar 2015 15:33:41 +0000
Message-ID: <1425396820.17965.16.camel@synopsys.com>
References: <1425395474-6762-1-git-send-email-abrodkin@synopsys.com>
	 <1425396362.14897.143.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425396362.14897.143.camel@linux.intel.com>
Content-Language: en-US
Content-ID: <6F791943B524844F8BB02DB7AB820B33@internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "alan@linux.intel.com" <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Hi Andy,

On Tue, 2015-03-03 at 17:26 +-0200, Andy Shevchenko wrote:
+AD4- On Tue, 2015-03-03 at 18:11 +-0300, Alexey Brodkin wrote:
+AD4- +AD4- It is not recommened to use platform+AF8-get+AF8-resource(pdev, IORESOURCE+AF8-IRQ)
+AD4- +AD4- for requesting IRQ's resources any more, as they can be not ready yet in
+AD4- +AD4- case of DT-booting.
+AD4- +AD4- 
+AD4- +AD4- platform+AF8-get+AF8-irq() instead is a recommended way for getting IRQ even if
+AD4- +AD4- it was not retrieved earlier.
+AD4- +AD4- 
+AD4- +AD4- It also makes code simpler because we're getting +ACI-int+ACI- value right away
+AD4- +AD4- and no conversion from resource to int is required.
+AD4- +AD4- 
+AD4- +AD4-  Changes in v2:
+AD4- +AD4-   +ACo- Suppress error message if platform+AF8-get+AF8-irq() returns -EPROBE+AF8-DEFER
+AD4- 
+AD4- Do we really need that message at all?

IMHO it makes sense.

For example it was useful for me when debugging stacked interrupt
controllers setup - I got explicitly notified why this particular device
failed on probe.

Note that IRQ is a pretty specific resource due to the fact of INTC
stacking and situations when each and every INTC gets finally probed.

Still if you believe we may drop this message with no loss of usability
- I'm fine with that as well.

-Alexey
