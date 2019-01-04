From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 4/4] tty: serial: qcom_geni_serial: Use u32 for register
 variables
Date: Fri, 4 Jan 2019 09:45:11 +0100
Message-ID: <20190104084511.GA17997@kroah.com>
References: <20190102213636.40866-1-ryandcase@chromium.org>
 <20190102213636.40866-5-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190102213636.40866-5-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ryan Case <ryandcase@chromium.org>
Cc: Jiri Slaby <jslaby@suse.com>, Evan Green <evgreen@chromium.org>, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Jan 02, 2019 at 01:36:36PM -0800, Ryan Case wrote:
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---
> 
>  drivers/tty/serial/qcom_geni_serial.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

I can not take patches without any changelog text, sorry.

greg k-h
