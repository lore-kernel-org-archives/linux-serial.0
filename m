From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH RFC 2/7] soc: qcom: Add device tree binding for GENI SE
Date: Tue, 2 Jan 2018 09:47:34 -0600
Message-ID: <20180102154734.pbomm5rehyquemp3@rob-hp-laptop>
References: <1514392046-30602-1-git-send-email-kramasub@codeaurora.org>
 <1514392046-30602-3-git-send-email-kramasub@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1514392046-30602-3-git-send-email-kramasub@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
Cc: linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, linux-doc@vger.kernel.org, devicetree@vger.kernel.org, andy.gross@linaro.org, david.brown@linaro.org, mark.rutland@arm.com, corbet@lwn.net, wsa@the-dreams.de, gregkh@linuxfoundation.org, jslaby@suse.com
List-Id: linux-serial@vger.kernel.org

On Wed, Dec 27, 2017 at 09:27:21AM -0700, Karthikeyan Ramasubramanian wrote:
> Add device tree binding support for the QCOM GENI SE driver.

Also, "dt-bindings: ..." is the preferred subject prefix. Same for the 
rest of the series.

> 
> Signed-off-by: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> ---
>  .../devicetree/bindings/soc/qcom/qcom,geni-se.txt         | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.txt
