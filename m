From: Frank Rowand <frowand.list@gmail.com>
Subject: regression: 3a878c430fd6 ("tty: serial: msm: Add TX DMA support")
 drops data
Date: Tue, 19 Apr 2016 16:23:29 -0700
Message-ID: <5716BDF1.1010407@gmail.com>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: ivan.ivanov@linaro.org
Cc: agross@codeaurora.org, David Brown <davidb@codeaurora.org>, srinivas.kandagatla@linaro.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, jslaby@suse.com, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, linux-soc@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Ivan,

It appears that I have found a regression caused by
3a878c430fd6 ("tty: serial: msm: Add TX DMA support").

When I cat a file slightly larger than 126000 bytes on
the console, viewed via minicom connected to the serial
port, I am losing random chunks of data, almost always
three bytes in length.  I have also seen a lost chunk
of two bytes.

I am using the 8074 dragonboard, with the dts of
arch/arm/boot/dts/qcom-apq8074-dragonboard.dts.
The dts node is serial@f991e000, which has a
compatible of "qcom,msm-uartdm-v1.4", so is_uartdm
should be UARTDM_1P4.

Do you have any thoughts on what might be going
wrong, or what I can do to debug this?

Thanks,

Frank
