import re

gmail_mapping = { 'INBOX'       : 'inbox'
          , '[Gmail]/All Mail'  : 'archive'
          , '[Gmail]/Drafts'    : 'drafts'
          , '[Gmail]/Important' : 'important'
          , '[Gmail]/Sent Mail' : 'sent'
          , '[Gmail]/Spam'      : 'spam'
          , '[Gmail]/Starred'   : 'starred'
          , '[Gmail]/Trash'     : 'trash'
          }

r_gmail_mapping = { val: key for key, val in gmail_mapping.items() }

def gmail_remote_nt(folder):
    return gmail_mapping.get(folder, folder)

def gmail_local_nt(folder):
    return r_gmail_mapping.get(folder, folder)

# folderfilter = exclude(['Label', 'Label', ... ])
def exclude(excludes):
    def inner(folder):
        try:
            excludes.index(folder)
            return False
        except:
            return True

    return inner

# yandex_mapping = { 'INBOX'                       : 'Inbox'
#           , '&BCcENQRABD0EPgQyBDgEOgQ4-'         : 'Drafts'
#           , '&BB4EQgQ,BEAEMAQyBDsENQQ9BD0ESwQ1-' : 'Sent'
#           , '&BCEEPwQwBDw-'                      : 'Spam'
#           , '&BCMENAQwBDsENQQ9BD0ESwQ1-'         : 'Trash'
# # not fully sure about starred
#           , '&BBgEQQRFBD4ENARPBEkEOAQ1-'         : 'Starred'
#           }

# r_yandex_mapping = { val: key for key, val in yandex_mapping.items() }

# def yandex_remote_nt(folder):
#     return yandex_mapping.get(folder, folder)

# def yandex_local_nt(folder):
#     return r_yandex_mapping.get(folder, folder)
