From: Hao Lee <haolee.swjtu@gmail.com>
Subject: Re: [PATCH v2] tty: serial: 8250: Fix type field in format string
Date: Tue, 30 Apr 2019 00:23:50 +0800
Message-ID: <CA+PpKPmFzLcE=gBwB9q0UNF1Rt1KU7_q3p9xyL-mh9g=imm22Q@mail.gmail.com>
References: <20190427091943.GA3810@haolee.io> <20190429143117.GA1474@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429143117.GA1474@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Mon, 29 Apr 2019 at 22:31, Greg KH <gregkh@linuxfoundation.org> wrote:
> This causes build warnings when applied, I'm having to drop it now.
>
> Please be more careful, when submitting patches, always test-build them
> first.

I have found my mistake. Although I have built a kernel to test my
patch, I forget to turn on the 8250 configurations which are turned
off during another kernel test. As a result, 8250_pnp.c was not
compiled at all, so I didn't see any warnings. Sorry for that and
thanks for your guidance. I will submit my patch v3.
