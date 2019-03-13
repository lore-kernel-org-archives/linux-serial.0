From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH 1/8] drivers: tty: serial: 8250_bcm2835aux: use
 devm_platform_ioremap_resource()
Date: Wed, 13 Mar 2019 07:59:53 +0100
Message-ID: <947da751-bbce-4364-a1bf-5487908e59a5@metux.net>
References: <1552402660-31730-1-git-send-email-info@metux.net>
 <1552402660-31730-2-git-send-email-info@metux.net>
 <20190312163356.GB13549@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190312163356.GB13549@kroah.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 12.03.19 17:33, Greg KH wrote:
> On Tue, Mar 12, 2019 at 03:57:33PM +0100, Enrico Weigelt, metux IT consult wrote:
>> ---
>>  drivers/tty/serial/8250/8250_bcm2835aux.c | 12 ++++--------
>>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> No changelog or signed-off-by, sorry, please fix up the series and
> resend.

Maybe the threading got messed up somehow (at least my tbird doesn't
show it correctly), so you've probably didn't see my intro letter: there
I wrote that this is yet WIP, not meant for actual submission, instead
just to ask you folks whether my approach in general would be work.

Sorry for the confusion.

Of course, when the stuff becomes ready for submission, all these
things will be cleaned up.


OTOH, if you think some of the patches indeed were ready, but yet need
some cleanups (like mentioned missing description), just let me know.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
