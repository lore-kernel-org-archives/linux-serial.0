From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: Re: [PATCH 5/5] serial/8250_fintek: Support for any io address.
Date: Mon, 15 Jun 2015 17:22:03 +0200
Message-ID: <CAPybu_2T2wzbfE2y8aYbhrAYoUEafY8di+YasCLNXSwe+CN-Kw@mail.gmail.com>
References: <1434377926-31958-1-git-send-email-ricardo.ribalda@gmail.com>
 <1434377926-31958-6-git-send-email-ricardo.ribalda@gmail.com> <1434378358.25843.11.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434378358.25843.11.camel@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Huewe <PeterHuewe@gmx.de>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Peter H <peter_hong@fintek.com.tw>
List-Id: linux-serial@vger.kernel.org

Hello Alan

On Mon, Jun 15, 2015 at 4:25 PM, Alan Cox <alan@linux.intel.com> wrote:

>
> Please however fix the dynamic on stack arrays you've got. Doing
>
>         blah foo[] = { 1,2,3,4 };
>
> might well be valid gcc but it generates horrible code when in fact your
> arrays should be static/const, not dynamically constructed on stack from
> a static copy each call.

Thanks for the comments, I have resubmitted the patchset.

>
> Reviewed-by: Alan Cox <alan@linux.intel.com>
>



-- 
Ricardo Ribalda
