From: Doug Anderson <dianders@google.com>
Subject: Re: [PATCH] tty: serial: qcom_geni_serial: Rectify UART suspend mechanism
Date: Tue, 16 Oct 2018 13:24:52 -0700
Message-ID: <CAD=FV=Uv6yaHCu7_N+ExLDRHHe6cRpNpc6vGBy-Q6kxavuuzNw@mail.gmail.com>
References: <1539699060-3055-1-git-send-email-msavaliy@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539699060-3055-1-git-send-email-msavaliy@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: msavaliy@codeaurora.org
Cc: alokc@codeaurora.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-serial@vger.kernel.org

Hi,

On Tue, Oct 16, 2018 at 7:11 AM Mukesh, Savaliya
<msavaliy@codeaurora.org> wrote:
>
> From: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
>
> UART driver checks for the PM state and denies suspend if state is ACTIVE.
> This makes UART to deny suspend when client keeps port open which is not
> correct. Instead follow framework and obey suspend-resume callbacks.
>
> Signed-off-by: Mukesh Kumar Savaliya <msavaliy@codeaurora.org>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 36 ++++++-----------------------------
>  1 file changed, 6 insertions(+), 30 deletions(-)

Looks peachy.  Getting rid of all that unnecessary code and moving
away from the "no_irq" suspend op makes lots of sense to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
