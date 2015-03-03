From: Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: Re: [PATCH v2] serial/8250_dw: use platform_get_irq() instead of
 platform_get_resource()
Date: Tue, 3 Mar 2015 15:47:37 +0000
Message-ID: <1425397657.17965.28.camel@synopsys.com>
References: <1425395474-6762-1-git-send-email-abrodkin@synopsys.com>
	 <1425396362.14897.143.camel@linux.intel.com>
	 <1425396820.17965.16.camel@synopsys.com>
	 <1425397427.14897.149.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425397427.14897.149.camel@linux.intel.com>
Content-Language: en-US
Content-ID: <1CE9E0B515A8924F967CD7492F99BAF0@internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Vineet.Gupta1@synopsys.com" <Vineet.Gupta1@synopsys.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "alan@linux.intel.com" <alan@linux.intel.com>
List-Id: linux-serial@vger.kernel.org

Hi Andy,

On Tue, 2015-03-03 at 17:43 +-0200, Andy Shevchenko wrote:
+AD4- On Tue, 2015-03-03 at 15:33 +-0000, Alexey Brodkin wrote:
+AD4- +AD4- Hi Andy,
+AD4- +AD4- 
+AD4- +AD4- On Tue, 2015-03-03 at 17:26 +-0200, Andy Shevchenko wrote:
+AD4- +AD4- +AD4- On Tue, 2015-03-03 at 18:11 +-0300, Alexey Brodkin wrote:
+AD4- +AD4- +AD4- +AD4- It is not recommened to use platform+AF8-get+AF8-resource(pdev, IORESOURCE+AF8-IRQ)
+AD4- +AD4- +AD4- +AD4- for requesting IRQ's resources any more, as they can be not ready yet in
+AD4- +AD4- +AD4- +AD4- case of DT-booting.
+AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- platform+AF8-get+AF8-irq() instead is a recommended way for getting IRQ even if
+AD4- +AD4- +AD4- +AD4- it was not retrieved earlier.
+AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4- It also makes code simpler because we're getting +ACI-int+ACI- value right away
+AD4- +AD4- +AD4- +AD4- and no conversion from resource to int is required.
+AD4- +AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- +AD4-  Changes in v2:
+AD4- +AD4- +AD4- +AD4-   +ACo- Suppress error message if platform+AF8-get+AF8-irq() returns -EPROBE+AF8-DEFER
+AD4- +AD4- +AD4- 
+AD4- +AD4- +AD4- Do we really need that message at all?
+AD4- +AD4- 
+AD4- +AD4- IMHO it makes sense.
+AD4- +AD4- 
+AD4- +AD4- For example it was useful for me when debugging stacked interrupt
+AD4- +AD4- controllers setup - I got explicitly notified why this particular device
+AD4- +AD4- failed on probe.
+AD4- 
+AD4- There are so many device drivers which prints similar message that you
+AD4- would consider to make a separate patch to platform.c code to do that
+AD4- stuff there once for all.
+AD4- 
+AD4- +AD4- Note that IRQ is a pretty specific resource due to the fact of INTC
+AD4- +AD4- stacking and situations when each and every INTC gets finally probed.
+AD4- +AD4- 
+AD4- +AD4- Still if you believe we may drop this message with no loss of usability
+AD4- +AD4- - I'm fine with that as well.
+AD4- 
+AD4- If no one else has an objection I would prefer to skip it. You always
+AD4- may get the return code from probe(), though it's not exactly mapped to
+AD4- the reason why it failed.

Then we may want to do another massive clean-up because there're lots of
other drivers that have this message in some form :)

-Alexey
