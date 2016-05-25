From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] tty: serial: msm: Remove duplicate handling of clocks
Date: Wed, 25 May 2016 16:07:55 -0700
Message-ID: <20160525230755.GA3468@codeaurora.org>
References: <1462957229-17567-1-git-send-email-pramod.gurav@linaro.org>
 <CANYu_0v9JuXjviJBTkC3YyyvmA3SmJxX8g9a7P+sMpu20FtONQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANYu_0v9JuXjviJBTkC3YyyvmA3SmJxX8g9a7P+sMpu20FtONQ@mail.gmail.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Pramod Gurav <pramod.gurav@linaro.org>
Cc: Andy Gross <andy.gross@linaro.org>, gregkh@linuxfoundation.org, David Brown <davidb@codeaurora.org>, jslaby@suse.com, linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 05/16, Pramod Gurav wrote:
> On 11 May 2016 at 14:30, Pramod Gurav <pramod.gurav@linaro.org> wrote:
> > msm_serial driver provides a .pm callback to the serial core to enable
> > and disable clock resource in suspend/resume path. This function is
> > also called before msm_startup. msm_startup also enables the clocks which
> > is not needed. Hence remove the duplcate clock operation from msm_startup
> > and msm_shutdown. Same is done in console setup to get rid of duplicate
> > clock operation.
> >
> > Tested on DB410C console.
> >
> > Signed-off-by: Pramod Gurav <pramod.gurav@linaro.org>
> > ---
> >  drivers/tty/serial/msm_serial.c | 15 ++-------------
> >  1 file changed, 2 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
> > index dcde955..73c3217 100644
> > --- a/drivers/tty/serial/msm_serial.c
> > +++ b/drivers/tty/serial/msm_serial.c
> > @@ -959,15 +959,6 @@ static int msm_set_baud_rate(struct uart_port *port, unsigned int baud,
> >         return baud;
> >  }
> >
> > -static void msm_init_clock(struct uart_port *port)
> > -{
> > -       struct msm_port *msm_port = UART_TO_MSM(port);
> > -
> > -       clk_prepare_enable(msm_port->clk);
> > -       clk_prepare_enable(msm_port->pclk);
> > -       msm_serial_set_mnd_regs(port);
> > -}
> > -
> >  static int msm_startup(struct uart_port *port)
> >  {
> >         struct msm_port *msm_port = UART_TO_MSM(port);
> > @@ -982,7 +973,7 @@ static int msm_startup(struct uart_port *port)
> >         if (unlikely(ret))
> >                 return ret;
> >
> > -       msm_init_clock(port);
> > +       msm_serial_set_mnd_regs(port);
> 
> Further testing with another UART port made me realize that serial
> port does not work after disabling msm_port->clk clock. The RX data
> part will be affected.
> Confirmed from manual that this clock should never be turned of to
> avoid loss of incoming data. Sorry for the noise.
> 

Does that mean this patch shouldn't be applied? I hope that the
pm callback would do the right thing and be called when we expect
to be receiving data on the line.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
