From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
Subject: Re: [PATCH v2] tty: serial: Add initial MSM UART High Speed Lite
 driver
Date: Mon, 29 Jul 2013 12:52:01 +0300
Message-ID: <1375091521.1956.54.camel@iivanov-dev.int.mm-sol.com>
References: <1374476749-12763-1-git-send-email-iivanov@mm-sol.com>
	 <20130726215023.GA1470@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20130726215023.GA1470@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: David Brown <davidb@codeaurora.org>
Cc: gregkh@linuxfoundation.org, grant.likely@linaro.org, rob.herring@calxeda.com, rob@landley.net, jslaby@suse.cz, devicetree-discuss@lists.ozlabs.org, linux-serial@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, mrana@codeaurora.org, sambley@codeaurora.org
List-Id: linux-serial@vger.kernel.org

Hi David, 

On Fri, 2013-07-26 at 14:50 -0700, David Brown wrote:
> On Mon, Jul 22, 2013 at 10:05:48AM +0300, Ivan T. Ivanov wrote:
> >From: "Ivan T. Ivanov" <iivanov@mm-sol.com>
> >
> >This is a tty driver with console support for Qualcomm's UART
> >controllers found in the MSM8974 chipsets. Driver is completely
> >based on implementation found in codeaurora.org msm_serial_hs_lite
> >with Android dependences removed. Other changes include, moved to
> >device managed resources and few cleanups.
> >
> >Driver functionality was tested in LEGACY_HSUART and BLSP_HSUART mode.
> 
> Ivan, do we need this driver with the fixes Stephen Boyd posted that
> are supposed to fix the problems with the existing msm_serial.c
> driver?  If a single driver can correctly support both devices, that
> seems like a better solution to me.

I have just tested Stephen's changes and they worked for me on 8074
based dragon board, so I am fine to drop my port of the HSL driver.

Regards,
Ivan

> 
> David
> 
