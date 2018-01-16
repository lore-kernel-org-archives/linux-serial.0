From: Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 1/7] qcom-geni-se: Add QCOM GENI SE Driver summary
Date: Tue, 16 Jan 2018 08:55:15 -0800
Message-ID: <20180116165515.GF478@tuxbook>
References: <1515805547-22816-1-git-send-email-kramasub@codeaurora.org>
 <1515805547-22816-2-git-send-email-kramasub@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1515805547-22816-2-git-send-email-kramasub@codeaurora.org>
Sender: linux-i2c-owner@vger.kernel.org
To: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: corbet@lwn.net, andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, gregkh@linuxfoundation.org, linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com
List-Id: linux-serial@vger.kernel.org

On Fri 12 Jan 17:05 PST 2018, Karthikeyan Ramasubramanian wrote:

> Generic Interface (GENI) firmware based Qualcomm Universal Peripheral (QUP)
> Wrapper is a programmable module that is composed of multiple Serial
> Engines (SE) and can support various Serial Interfaces like UART, SPI,
> I2C, I3C, etc. This document provides a high level overview of the GENI
> based QUP Wrapper.
> 
> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>

Rather than adding a disconnected chunk of documentation move this into
the driver(s), using the format described in
https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html?highlight=kernel%20doc#overview-documentation-comments 

Regards,
Bjorn
