From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] linux/serdev.h: Replace 'ctrl->serdev' with 'serdev'
Date: Wed, 15 Mar 2017 09:28:34 -0500
Message-ID: <CAL_JsqKR8XvgFYNYDttc_pooNNN8PB6cOTHyYHzCo3zCKwUxYw@mail.gmail.com>
References: <20170314134839.19619-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170314134839.19619-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Tue, Mar 14, 2017 at 8:48 AM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> Replace 'ctrl->serdev' with 'serdev' in serdev_controller_write_wakeup()
> and serdev_controller_receive_buf().
>
> Cc: cphealy@gmail.com
> Cc: linux-serial@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  include/linux/serdev.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>

But I think you will have to resend and copy Greg KH so he can apply it.

Rob
