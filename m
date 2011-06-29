From: Alan Cox <alan@linux.intel.com>
Subject: Re: [PATCH] tty: serial: samsung.c remove legacy PM code.
Date: Wed, 29 Jun 2011 13:55:02 +0100
Message-ID: <20110629135502.2261f9e8@bob.linux.org.uk>
References: <1309328904-19267-1-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1309328904-19267-1-git-send-email-myungjoo.ham@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, kyungmin.park@samsung.com, myungjoo.ham@gmail.com
List-Id: linux-serial@vger.kernel.org

On Wed, 29 Jun 2011 15:28:24 +0900
MyungJoo Ham <myungjoo.ham@samsung.com> wrote:

> This patch "modernize" tty/serial/samsung.c to use non-legacy code for
> suspend/resume.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: KyungMin Park <kyungmin.park@samsung.com>

Looks fine to me - no tty/serial bits involved though
