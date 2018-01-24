From: Evan Green <evgreen@chromium.org>
Subject: Re: [v2, 7/7] tty: serial: msm_geni_serial: Add serial driver support
 for GENI based QUP
Date: Wed, 24 Jan 2018 15:07:54 -0800
Message-ID: <CAE=gft437Q6S_qoA7TKto9ZqQD-1v-qoUvJOmBmKxjNdaukckw@mail.gmail.com>
References: <1515805547-22816-8-git-send-email-kramasub@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1515805547-22816-8-git-send-email-kramasub@codeaurora.org>
Sender: linux-doc-owner@vger.kernel.org
To: corbet@lwn.net, andy.gross@linaro.org, david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, wsa@the-dreams.de, gregkh@linuxfoundation.org
Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, linux-serial@vger.kernel.org, jslaby@suse.com, Girish Mahadevan <girishm@codeaurora.org>, Sagar Dharia <sdharia@codeaurora.org>
List-Id: linux-serial@vger.kernel.org

On Fri, Jan 12, 2018 at 5:05 PM, Karthikeyan Ramasubramanian
<kramasub@codeaurora.org> wrote:
> +static int get_clk_cfg(unsigned long clk_freq, unsigned long *ser_clk)
> +{
> +       unsigned long root_freq[] = {7372800, 14745600, 19200000, 29491200,
> +               32000000, 48000000, 64000000, 80000000, 96000000, 100000000};

This table should be static const, right?
