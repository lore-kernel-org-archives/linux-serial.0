From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 1/8] drivers: tty: serial: 8250_bcm2835aux: use devm_platform_ioremap_resource()
Date: Wed, 13 Mar 2019 12:28:35 +0100
Message-ID: <CANiq72=SBFzRVhpkH8V+=5E-adzJ4v6UGAPKfr18wnCB0rcoQA@mail.gmail.com>
References: <1552402660-31730-1-git-send-email-info@metux.net>
 <1552402660-31730-2-git-send-email-info@metux.net> <20190312163356.GB13549@kroah.com>
 <947da751-bbce-4364-a1bf-5487908e59a5@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <947da751-bbce-4364-a1bf-5487908e59a5@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Cc: Greg KH <gregkh@linuxfoundation.org>, "Enrico Weigelt, metux IT consult" <info@metux.net>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

On Wed, Mar 13, 2019 at 8:03 AM Enrico Weigelt, metux IT consult
<lkml@metux.net> wrote:
>
> On 12.03.19 17:33, Greg KH wrote:
> > On Tue, Mar 12, 2019 at 03:57:33PM +0100, Enrico Weigelt, metux IT consult wrote:
> >> ---
> >>  drivers/tty/serial/8250/8250_bcm2835aux.c | 12 ++++--------
> >>  1 file changed, 4 insertions(+), 8 deletions(-)
> >
> > No changelog or signed-off-by, sorry, please fix up the series and
> > resend.
>
> Maybe the threading got messed up somehow (at least my tbird doesn't
> show it correctly), so you've probably didn't see my intro letter: there

The intro letter seems to be an independent message with a different
subject line -- not sure what threading you expected (?).

> I wrote that this is yet WIP, not meant for actual submission, instead
> just to ask you folks whether my approach in general would be work.

That will indeed cause confusion. If you are requesting comments only,
please do so placing [RFC] or similar in the subject of each patch
(you did in the letter, but that had a different title, and it is
not how cover letters are usually sent, they are normally patch 0).

Another option is sending a message with the repo URL where
development is happening, so interested parties can take a look.

However:

> Of course, when the stuff becomes ready for submission, all these
> things will be cleaned up.

Even if you are sending some draft patches, it is still a bad idea to
send them incomplete. Basically you are making it harder for early
reviewers simply by not having written an explanation or at least a
reference to the explanation.

Cheers,
Miguel
