From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 53/61] tty: serial: simplify getting .drvdata
Date: Fri, 20 Apr 2018 09:23:41 +0200
Message-ID: <ce3c4fa9-c6bc-a529-3c91-9f353d017720@xilinx.com>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-54-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180419140641.27926-54-wsa+renesas@sang-engineering.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org, kernel-janitors@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Patrice Chotard <patrice.chotard@st.com>, Michal Simek <michal.simek@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

On 19.4.2018 16:06, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/tty/serial/imx.c              | 18 ++++++------------
>  drivers/tty/serial/qcom_geni_serial.c |  6 ++----
>  drivers/tty/serial/st-asc.c           |  6 ++----
>  drivers/tty/serial/xilinx_uartps.c    |  6 ++----

Acked-by: Michal Simek <michal.simek@xilinx.com> (for xilinx)

Thanks,
Michal
