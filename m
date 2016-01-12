From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v4 10/11] of: earlycon: Log more helpful message if
 stdout-path node not found
Date: Tue, 12 Jan 2016 17:38:11 -0600
Message-ID: <CAL_JsqJzAC4NkiSGrUm45yRpw6np6YUzpniQETtqe1xyRhb8cQ@mail.gmail.com>
References: <1428515119-25248-1-git-send-email-peter@hurleysoftware.com>
 <1452627672-9482-1-git-send-email-peter@hurleysoftware.com> <1452627672-9482-11-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452627672-9482-11-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Grant Likely <grant.likely@linaro.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kevin Cernekee <cernekee@gmail.com>, Jon Hunter <jonathanh@nvidia.com>, Sebastian Frias <sf84@laposte.net>, Paul Burton <paul.burton@imgtec.com>
List-Id: linux-serial@vger.kernel.org

On Tue, Jan 12, 2016 at 1:41 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> Earlycon may fail to initialize for a variety of reasons, most of
> which log the default early param message. If the stdout-path node is
> not found, log the path which was not found (and suppress the
> default early param message).
>
> Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
> ---
>  drivers/of/fdt.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
