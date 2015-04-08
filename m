From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH 1/2] tty: serial: msm: Add mask value for UART_DM registers
Date: Wed, 08 Apr 2015 14:22:38 +0100
Message-ID: <55252B9E.4070403@linaro.org>
References: <1428498794-20833-1-git-send-email-gpramod@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1428498794-20833-1-git-send-email-gpramod@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pramod Gurav <gpramod@codeaurora.org>, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bryanh@codeaurora.org, sboyd@codeaurora.org, jslaby@suse.cz
List-Id: linux-serial@vger.kernel.org



On 08/04/15 14:13, Pramod Gurav wrote:
> There is no bit setting as UART_IPR_RXSTALE_LAST for UART_DM core so do
> it only for UART core.
>
> Signed-off-by: Pramod Gurav<gpramod@codeaurora.org>
> --
>
> Changes since last version:
>   - Added new macro fo UART_DM_MR1_AUTO_RFR_LEVEL1 instead of modifying existing.
>   - Added a new macro for IPR register as it is also different in UART_DM
>   - Changed subject line
>
> ---

Change log should come after ---, else it will end up in git log.


--srini
