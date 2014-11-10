From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] tty: serial: msm_serial: Use DT aliases
Date: Mon, 10 Nov 2014 15:53:12 -0800
Message-ID: <54614FE8.6060904@codeaurora.org>
References: <1414024381-12204-1-git-send-email-sboyd@codeaurora.org> <545C4E1F.4060401@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:50065 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464AbaKJXxO (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 10 Nov 2014 18:53:14 -0500
In-Reply-To: <545C4E1F.4060401@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: frowand.list@gmail.com
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

On 11/06/2014 08:44 PM, Frank Rowand wrote:
> From: Frank Rowand <frank.rowand@sonymobile.com>
>
> Update devicetree binding for msm_serial to reflect msm_serial_probe()
> getting line id from the serial alias.
>
> Signed-off-by: Frank Rowand <frank.rowand@sonymobile.com>
> ---
>  Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt |   15 +++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> Index: b/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
> ===================================================================
> --- a/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
> +++ b/Documentation/devicetree/bindings/serial/qcom,msm-uartdm.txt
> @@ -27,11 +27,18 @@ Optional properties:
>  - dmas: Should contain dma specifiers for transmit and receive channels
>  - dma-names: Should contain "tx" for transmit and "rx" for receive channels
>  
> +Additional requirements:
> +- Each UART port must have an alias correctly numbered in "aliases" node.

s/requirements/notes/
s/must/can/

It wasn't the intention to make it a requirement.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

