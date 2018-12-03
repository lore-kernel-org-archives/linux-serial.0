From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v3] tty: serial: qcom_geni_serial: Fix softlock
Date: Mon, 03 Dec 2018 08:22:15 -0800
Message-ID: <154385413596.88331.2252934244242692154@swboyd.mtv.corp.google.com>
References: <20181130021840.75861-1-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181130021840.75861-1-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Evan Green <evgreen@chromium.org>, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Ryan Case <ryandcase@chromium.org>
List-Id: linux-serial@vger.kernel.org

Quoting Ryan Case (2018-11-29 18:18:40)
> Transfers were being divided into device FIFO sized (64 byte max)
> operations which would poll for completion within a spin_lock_irqsave /
> spin_unlock_irqrestore block. This both made things slow by waiting for
> the FIFO to completely drain before adding further data and would also
> result in softlocks on large transmissions.
> =

> This patch allows larger transfers with continuous FIFO additions as
> space becomes available and removes polling from the interrupt handler.
> =

> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
