From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH v2 1/3] serial: sh-sci: Add OF support
Date: Wed, 27 Feb 2013 17:04:14 +0900
Message-ID: <20130227080413.GA21690@linux-sh.org>
References: <1361819215-4115-1-git-send-email-hechtb+renesas@gmail.com>
 <20130225203534.GB19670@linux-sh.org>
 <CABYn4szH8QnPAj6dkv94wEVr6b=ezb2f7fxyiMnhF7AqOBOMpQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABYn4szH8QnPAj6dkv94wEVr6b=ezb2f7fxyiMnhF7AqOBOMpQ@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Bastian Hecht <hechtb@gmail.com>
Cc: linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On Tue, Feb 26, 2013 at 09:09:52AM -0600, Bastian Hecht wrote:
> 2013/2/25 Paul Mundt <lethal@linux-sh.org>:
> > You can then compare against SCIx_PROBE_REGTYPE and SCIx_NR_REGTYPES, and
> > assign p->regtype the be32_to_cpup() value directly. Which will also make
> > it trivial to add new regtypes in the future, we would only need to
> > update the binding documentation.
> 
> Ok, I slightly disliked that portion anyway in the code as we have the
> full mapping from the SCBRR algo ID and only the partial mapping from
> the register set. Additionally I wonder if I should add something like
> 
> enum {
> +     SCBRR_ALGO_INVALID,
>        SCBRR_ALGO_1,
>        SCBRR_ALGO_2,
>        SCBRR_ALGO_3,
>        SCBRR_ALGO_4,
>        SCBRR_ALGO_5,
> };
> ...
> -p->scbrr_algo_id = be32_to_cpup(prop) - 1;
> +p->scbrr_algo_id = be32_to_cpup(prop);
> 
> to have a straight mapping.

Yes, that would be my preferred option as well. I was going to comment on
the - 1 thing previously, but figured it was just some DT oddity.
