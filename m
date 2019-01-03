From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH 4/4] tty: serial: qcom_geni_serial: Use u32 for register variables
Date: Thu, 03 Jan 2019 13:22:15 -0800
Message-ID: <154655053537.15366.12329201016969398011@swboyd.mtv.corp.google.com>
References: <20190102213636.40866-1-ryandcase@chromium.org> <20190102213636.40866-5-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190102213636.40866-5-ryandcase@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Evan Green <evgreen@chromium.org>, Doug Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Ryan Case <ryandcase@chromium.org>
List-Id: linux-serial@vger.kernel.org

Quoting Ryan Case (2019-01-02 13:36:36)
> Signed-off-by: Ryan Case <ryandcase@chromium.org>
> ---

It'd be nice to have any sort of commit text here with the motivation
for the change (code clarity is my motivation).

Besides that nitpick

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
