From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH] Revert "tty: Fix pty master poll() after slave closes
 v2"
Date: Tue, 30 Dec 2014 07:31:06 -0500
Message-ID: <54A29B0A.3060707@hurleysoftware.com>
References: <1419941829-6536-1-git-send-email-peter@hurleysoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1419941829-6536-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Francesco Ruggeri <fruggeri@aristanetworks.com>, Francesco Ruggeri <fruggeri@arista.com>
List-Id: linux-serial@vger.kernel.org

On 12/30/2014 07:17 AM, Peter Hurley wrote:
> This reverts commit c4dc304677e8d566572c4738d95c48be150c6606.
> This fix is superseded by commit 52bce7f8d4fc633c9a9d0646eef58ba6ae9a3b73,
> 'pty, n_tty: Simplify input processing on final close'.
> 
> The final close now waits for input processing to complete before
> destroying the pty, so poll() does not need to special case this
> condition.

Greg,

As noted in this commit log, commit c4dc304677e8d566572c4738d95c48be150c6606,
'tty: Fix pty master poll() after slave closes v2', is not required
after commit 52bce7f8d4fc633c9a9d0646eef58ba6ae9a3b73,
'pty, n_tty: Simplify input processing on final close'

However, 'tty: Fix pty master poll() after slave closes v2' is appropriate
for stable back to v3.12.

Regards,
Peter Hurley
