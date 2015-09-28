From: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
Subject: Re: [PATCH 0/7] tty: serial: msm: Add DMA support and fix bit
 definitions
Date: Mon, 28 Sep 2015 10:49:26 +0300
Message-ID: <1443426566.2363.0.camel@linaro.org>
References: <1442062934-13449-1-git-send-email-ivan.ivanov@linaro.org>
	 <560486D7.3090003@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <560486D7.3090003@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Andy Gross <agross@codeaurora.org>, David Brown <davidb@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Frank Rowand <frank.rowand@sonymobile.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org


On Fri, 2015-09-25 at 00:27 +0100, Srinivas Kandagatla wrote:
> Hi Ivan,
> On 12/09/15 14:02, Ivan T. Ivanov wrote:
> > Hi,
> > 
> > Following patches add DMA support for UARTDM type of hardware.
> > 
> > Changes have been tested on UARTDM v1.3(APQ8064) and v1.4(APQ8016).
> > 
> > Patches from Gurav were published long ago here[1], I just addressed
> > remaining comments and coding style issues.
> > 
> > Any comments are welcome.
> Looks like Magic Sysrq is broken with this patches.


Will check it shortly.

Thanks,
Ivan
