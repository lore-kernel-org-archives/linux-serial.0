From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] n_tty: Remove LINEMODE support
Date: Mon, 19 Jan 2015 11:34:55 -0500
Message-ID: <54BD322F.1020401@hurleysoftware.com>
References: <1421616632-4077-1-git-send-email-peter@hurleysoftware.com> <54BC2F0A.8040404@symas.com> <54BC3236.1030004@hurleysoftware.com> <54BC3730.706@symas.com> <54BC3C89.3070006@hurleysoftware.com> <20150119045501.GB29596@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150119045501.GB29596@thunk.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Howard Chu <hyc@symas.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Hi Ted,

On 01/18/2015 11:55 PM, Theodore Ts'o wrote:
> Line mode goes back to BSD 4.x days, and it's useful over high latency
> links --- i.e., the sort of thing that you get with stone age cellular
> data networks (i.e., the sort of thing that we still have the US),
> amateur packet radio links, etc.  So it's certianly a nice to have, if
> someone is willing to support it and the maintenance burden on the
> rest of the tty stack isn't too onerous.

I'm not philosophically opposed to Line mode support, but I am
concerned about providing a userspace interface that's not getting tested
or used or otherwise not fit for purpose. I copied you on the other email
regarding the specific deficiencies so I won't reiterate them here.

Perhaps it's fortunate that userspace didn't pick this up; otherwise,
this interface would be cast in stone.

Regards,
Peter Hurley
