From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH 1/8] drivers: tty: serial: 8250_bcm2835aux: use
 devm_platform_ioremap_resource()
Date: Wed, 13 Mar 2019 15:09:23 +0100
Message-ID: <939d94a2-f44d-27a6-e894-1f846c6b3b5c@metux.net>
References: <1552402660-31730-1-git-send-email-info@metux.net>
 <1552402660-31730-2-git-send-email-info@metux.net>
 <20190312163356.GB13549@kroah.com>
 <947da751-bbce-4364-a1bf-5487908e59a5@metux.net>
 <CANiq72=SBFzRVhpkH8V+=5E-adzJ4v6UGAPKfr18wnCB0rcoQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CANiq72=SBFzRVhpkH8V+=5E-adzJ4v6UGAPKfr18wnCB0rcoQA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On 13.03.19 12:28, Miguel Ojeda wrote:

Hi,

> The intro letter seems to be an independent message with a different> subject line -- not sure what threading you expected (?).
hmm, I've sent it via git-send-email --compose. IMHO, this should
send the intro as the first message and the actual patches as reply.

But it seems that didn't work as I hoped.

>> I wrote that this is yet WIP, not meant for actual submission, instead>> just to ask you folks whether my approach in general would be work.>
> That will indeed cause confusion. If you are requesting comments
only,> please do so placing [RFC] or similar in the subject of each patch

Ah, good idea. So I also have this tag in the git repo.
BTW: are there more such conventions I should be aware of ?

> Another option is sending a message with the repo URL where> development is happening, so interested parties can take a look.
Ok. I had the impression that people here don't really like to look
at some git repos for reviews.

> Even if you are sending some draft patches, it is still a bad idea to> send them incomplete. Basically you are making it harder for early>
reviewers simply by not having written an explanation or at least a>
reference to the explanation.
Understood.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
