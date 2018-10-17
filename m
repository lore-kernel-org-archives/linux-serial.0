From: msavaliy@codeaurora.org
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Don't slow all ports just
 for kgdb
Date: Wed, 17 Oct 2018 13:04:10 +0530
Message-ID: <6a4b57b252c01d312be10ce586be7d7d@codeaurora.org>
References: <20181015204425.84537-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181015204425.84537-1-dianders@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Douglas Anderson <dianders@chromium.org>
Cc: gregkh@linuxfoundation.org, linux-arm-msm@vger.kernel.org, alokc@codeaurora.org, mka@chromium.org, evgreen@chromium.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>, linux-arm-msm-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 2018-10-16 02:14, Douglas Anderson wrote:
> If you turn on CONFIG_KGDB then you'll get CONFIG_CONSOLE_POLL
> selected.
> 
> If you have CONFIG_CONSOLE_POLL selected then the GENI serial driver
> was setting RX_BYTES_PW to 1 for _all_ UART ports.
> 
> This doesn't seem like such a good idea.  Let's only set RX_BYTES_PW
> to 1 for the console port.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
>  drivers/tty/serial/qcom_geni_serial.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
Good finding, Makes sense to keep changes this way for console only 
port.

Reviewed-by: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
