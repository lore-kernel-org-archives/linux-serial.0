From: Peter Hurley <peter@hurleysoftware.com>
Subject: Re: [PATCH 01/15] cyclades: Deinline cyz_is_loaded, save 240 bytes
Date: Tue, 27 Oct 2015 14:18:21 -0400
Message-ID: <562FBFED.3010103@hurleysoftware.com>
References: <1445968007-12616-1-git-send-email-dvlasenk@redhat.com>
 <1445968007-12616-2-git-send-email-dvlasenk@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445968007-12616-2-git-send-email-dvlasenk@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Denys Vlasenko <dvlasenk@redhat.com>, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

On 10/27/2015 01:46 PM, Denys Vlasenko wrote:
> This function compiles to 58 bytes of machine code.

Reviewed-by: Peter Hurley <peter@hurleysoftware.com>
