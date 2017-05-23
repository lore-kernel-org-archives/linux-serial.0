From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH V1] serial: imx: revert setup DCEDTE early and ensure DCD
 and RI irqs to be off
Date: Tue, 23 May 2017 13:26:28 -0300
Message-ID: <CAOMZO5CT5MS1WGm_rCJ61Ambh+rMapsQWD84RXtagtt3HhmZwg@mail.gmail.com>
References: <20170523123145.E268B3FAD4@swsrvapps-01.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170523123145.E268B3FAD4@swsrvapps-01.diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, LINUX-KERNEL <linux-kernel@vger.kernel.org>, LINUX-SERIAL <linux-serial@vger.kernel.org>, Lucas Stach <l.stach@pengutronix.de>, Uwe Kleine-Konig <u.kleine-koenig@pengutronix.de>, Support Opensource <support.opensource@diasemi.com>
List-Id: linux-serial@vger.kernel.org

Hi Steve,

On Tue, May 23, 2017 at 9:17 AM, Steve Twiss
<stwiss.opensource@diasemi.com> wrote:
> From: Steve Twiss <stwiss.opensource@diasemi.com>
>
> Revert the commit e61c38d85b7392e ("serial: imx: setup DCEDTE early and
> ensure DCD and RI irqs to be off")
>
> The patch submitted to setup DCEDTE early and ensure DCD and RI irqs to
> be off, causes a serial console display problem the i.MX6Q SABRESD board.
> The console becomes unreadable and unwritable.
>
> Tested-by: Steve Twiss <stwiss.opensource@diasemi.com>
> Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
>
> ---
> This patch applies against linux-next and v4.12-rc2
>
> Hi,
>
> I have been seeing a problem with the serial output console on the i.MX6Q
> SABRESD, but not the i.MX6DL SABRESD. Everything was fine up to
> linux-mainline/v4.11 but changed after linux-next/next-20170501.
>
> Some bisection has pointed at the commit
> e61c38d85b7392e033ee03bca46f1d6006156175 which, once removed from my
> linux-next/v4.12-rc2 build allows the i.MX6Q board to display the console
> correctly again.
>
> This patch removes the original commit e61c38d85b7392e ("serial: imx:
> setup DCEDTE early and ensure DCD and RI irqs to be off") from  linux-next
> v4.12-rc2 and fixes the serial problem seen in the i.MX6Q SABRESD board.

How can the error be reproduced?

Care to share more details of the error, please?
